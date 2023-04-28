require 'rails_helper'

describe Category, type: :model do
  subject do
    Category.new(
      name: 'Food',
      icon: 'https://images.pexels.com/photos/12745010/'
    )
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil 
    expect(subject).to_not be_valid
  end

  it 'icon should be present and displayed' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end
end