require 'rails_helper'

describe '/payments', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:payment) do
    user.payments.create(name: 'Cable', amount: 300)
  end

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

    it 'should create a new payment' do
      expect do
        post payments_path,
             params: { payment: { name: 'Cable', amount: 300 } }
      end.to change(Payment, :count).by(1)
    end

    it 'should redirect to payments_path' do
      post payments_path,
           params: { payment: { name: 'Cable', amount: 300 } }
      expect(response).to redirect_to payments_path
    end
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