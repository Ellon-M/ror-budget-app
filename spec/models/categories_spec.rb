require 'rails_helper'

describe Category, type: :model do
  subject do
    Category.new(
      name: 'Food'
    )
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
