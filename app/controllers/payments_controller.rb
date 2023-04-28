class PaymentsController < ApplicationController
  before_action :set_payments, only: %i[destroy]

  def index
    @user = current_user
    @categories = Category.where(user: @user)
    @payments = @user.payments
  end

  def new
    @user = current_user
    @payment = Payment.new
    @categories = Category.where(user: @user)
    return unless params[:category_id]
    
    @category = Category.find(params[:category_id])
  end

  def create
    @user = current_user
    @payment = @user.payments.new(payment_params.except(:category_id))
    find_payment_categories(@payment, params[:payment][:category_id])

    if @payment.save
      redirect_to payments_path, notice: 'Transaction successfully added.'
    else
      redirect_to payments_path, alert: 'Something went wrong.'
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        if @payment.destroy
          redirect_to payments_path, notice: 'Payment deleted successfully'
        else
          redirect_to payments_path, alert: 'Something went wrong! Try again'
        end
      end
    end
  end

  private

  def find_payment_categories(payment, categories)
    if categories
      payment.categories << Category.find(categories)
    end
  end

  def set_payments
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end