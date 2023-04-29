require 'rails_helper'

describe Payment, type: :model do
  subject do
    Payment.new(
      name: 'Cable',
      amount: 300,
      author_id: 1
    )
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'amount should be present' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end
end
