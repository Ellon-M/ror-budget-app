class PaymentsController < ApplicationController
  before_action :set_payments, only: %i[destroy]

  def index
    @user = current_user
    @payments = @user.payments
  end

  def new
    @user = current_user
    @payment = Payment.new
  end

  def create
    @user = current_user
    @payment = @user.payments.new(author: @user, name: params[:payment][:name], amount: params[:payment][:amount])
    create_or_delete_payment_categories(@payment, params[:payment][:categories])

    if @payment.save
      redirect_to payments_url, notice: 'Payment sucessfully added.'
    else
      redirect_to payments_path, alert: 'Something went wrong.'
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        if @payment.destroy
          redirect_to payments_url, notice: 'Payment deleted successfully'
        else
          redirect_to payments_path, alert: 'Something went wrong! Try again'
        end
      end
    end
  end

  private

  def create_or_delete_payment_categories(payment, categories)
    categories.category_payments.destroy_all
    categories.each do |category|
      payment.categories << Category.find_or_create_by(name: category)
    end
  end

  def set_payments
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, :categories)
  end
end
