require 'rails_helper'

describe 'categories/new', type: :view do
  include Devise::Test::IntegrationHelpers
  before(:example) do
    @user = User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now)
    @category = Category.create(name: 'Groceries', icon: 'https://images.pexels.com/photos/12745010/', user: @user)
    @payment = Payment.create(name: 'Salt', amount: 10, author: @user)
    @payment.categories << @category

    sign_in @user
    visit new_category_path
  end

  it 'renders a new category page' do
    expect(page).to have_content 'Add Category'
  end

  it 'fills and submits form' do
    fill_in 'category[name]', with: 'Groceries'
    fill_in 'category[icon]', with: 'https://images.pexels.com/photos/12745010/'
    find("input[type='submit']").click
    sleep 1
    expect(current_path).to eql categories_path
  end
end
