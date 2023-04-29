require 'rails_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe 'payments/new', type: :view do
  include Devise::Test::IntegrationHelpers
  before(:example) do
    @user = User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now)
    @category = Category.create(name: 'Groceries',
                                icon: fixture_file_upload('app/assets/images/asunaa.jpg', 'image/jpeg'), user: @user)
    @payment = Payment.create(name: 'Salt', amount: 10, author: @user)
    @payment.categories << @category
    sign_in @user
    visit new_payment_path
  end

  it 'displays add transaction page' do
    expect(page).to have_content 'Add Transaction'
  end

  it 'navigates back to the previous route' do
    visit category_path(@category)
    find("a[class='add-category-container']").click
    find("a[class='back']").click
    sleep 1
    expect(current_path).to eql category_path(@category)
  end

  it 'fills and submits form' do
    fill_in 'payment[name]', with: 'Milk'
    fill_in 'payment[amount]', with: 10
    find("input[type='checkbox']").click
    find("input[type='submit']").click
    sleep 1
    expect(current_path).to eql category_path(@category)
  end
end
