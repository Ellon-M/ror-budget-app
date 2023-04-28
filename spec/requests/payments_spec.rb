require 'rails_helper'

describe '/payments', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:payment) do
    user.payments.create(name: 'Cable', amount: 300)
  end
  let(:category) { Category.create(name: 'Housing') }

  describe 'GET /index' do
    before(:example) do
      sign_in user
      get payments_path
    end

    it 'has a successful response' do
      expect(response).to be_successful
    end
    it 'correctly renders the index html template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /new' do
    before do
      sign_in user
      get new_payment_path
    end

    it 'has a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    before do
      sign_in user
      get new_payment_path
    end

    context 'with valid params' do
      it 'creates a new payment and redirects to the index page' do
        expect {
          post '/payments', params: { payment: { name: 'Rent', amount: 1000} }
        }.to change { Payment.count }.by(1)
  
        expect(response).to redirect_to('/payments')
      end
    end

    # context 'with invalid params' do
    #   it 'does not create a new payment and renders the new page with an error message' do
    #     expect {
    #       post '/payments', params: { payment: { name: '', amount: 0 } }
    #     }.not_to change { Payment.count }
  
    #     expect(response).to redirect_to('/payments')
    #     follow_redirect!
    #     expect(response.body).to include('Something went wrong.')
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'should delete a payment' do
      sign_in user
      payment
      expect do
        delete payment_path(payment)
      end.to change(Payment, :count).by(-1)
    end
  end
end