class Payment < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :author, class_name: 'User'
  has_many :category_payments, dependent: :destroy
  has_many :categories, through: :category_payments, dependent: :destroy

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_payment
    payment.sum('amount')
  end
end 
