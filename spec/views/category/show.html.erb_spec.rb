require 'rails_helper'

describe 'categories/show', type: :view do
  include Devise::Test::IntegrationHelpers
  before(:example) do
    @user = User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now)
    @category = Category.create(name: 'Groceries', icon: 'https://images.pexels.com/photos/12745010/', user: @user)
    @payment = Payment.create(name: 'Salt', amount: 10, author: @user)
    @payment.categories << @category

    sign_in @user
    visit category_path(@category)
  end

  it 'displays payments' do
    expect(page).to have_content 'Salt'
  end

  it 'clicks on back' do
    find("a[href='/categories']").click
    sleep 1
    expect(current_path).to eql categories_path
  end

  it 'clicks on Add Transaction' do
    find("a[href='/payments/new?category_id=#{@category.id}']").click
    sleep 1
    expect(current_path).to eql new_payment_path
  end

  it 'click on logout' do
    find("button[class='login-button']").click
    expect(current_path).to eql root_path
  end
end
