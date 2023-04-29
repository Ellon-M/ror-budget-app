require 'rails_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe 'categories/ index', type: :view do
  include Devise::Test::IntegrationHelpers
  before(:example) do
    @user = User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now)
    @category = Category.create(name: 'Groceries', icon: fixture_file_upload('app/assets/images/asunaa.jpg', 'image/jpeg'), user: @user)
    @payment = Payment.create(name: 'Salt', amount: 10, author: @user)
    @payment.categories << @category
    sign_in @user
    assign(:category, @category)
    visit categories_path
  end

  it 'displays a list of categories' do
    expect(page).to have_content 'Groceries'
  end

  it 'clicks on a new category' do
    find("a[href='/categories/new']").click
    sleep 1
    expect(current_path).to eql new_category_path
  end
end
