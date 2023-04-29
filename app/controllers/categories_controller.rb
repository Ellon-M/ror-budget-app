class CategoriesController < ApplicationController
  before_action :set_categories, only: %i[destroy]

  def index
    @user = current_user
    @categories = @user.categories
  end

  def show
    @category = Category.find(params[:id])
    @payments = @category.payments.order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_url, notice: 'Category sucessfully added.'
    else
      redirect_to categories_path, alert: 'Something went wrong.'
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_url, notice: 'Category deleted successfully.'
    else
      redirect_to categories_path, notice: 'Something went wrong'
    end
  end

  private

  def set_categories
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
