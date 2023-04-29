require 'rails_helper'

describe 'categories/new', type: :view do
  include Devise::Test::IntegrationHelpers
  before(:example) do
    @user = User.create(name: 'Ellon', email: 'ellon@gmail.com', password: 'password', confirmed_at: Time.now)
    @category = Category.create(name: 'Groceries',
                                icon: fixture_file_upload('app/assets/images/asunaa.jpg', 'image/jpeg'), user: @user)
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
    find('input[type="file"]').set('app/assets/images/asunaa.jpg')
    find("input[type='submit']").click
    sleep 1
    expect(current_path).to eql categories_path
  end
end
