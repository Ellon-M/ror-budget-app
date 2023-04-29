require 'rails_helper'

describe '/categories', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) do
    user.categories.create(name: 'Food')
  end

  before { sign_in user }

  describe 'GET /index' do
    before(:example) do
      get categories_path
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
      get new_category_path
    end

    it 'has a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    before do
      get new_category_path
    end

    it 'should create a new category' do
      expect do
        post categories_path,
             params: { category: { name: 'Food' } }
      end.to change(Category, :count).by(1)
    end

    it 'should redirect to categories_path' do
      post categories_path,
           params: { category: { name: 'Food' } }
      expect(response).to redirect_to categories_path
    end
  end

  describe 'DELETE /destroy' do
    it 'should delete a category' do
      category
      expect do
        delete category_path(category)
      end.to change(Category, :count).by(-1)
    end
  end
end
