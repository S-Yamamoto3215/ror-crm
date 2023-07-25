require 'rails_helper'

RSpec.describe Classification, type: :model do
  it 'is valid if there is a post and a tag' do
    expect(FactoryBot.build(:classification)).to be_valid
  end

  it 'is invalid if there is no post' do
    classification = FactoryBot.build(:classification, post: nil)
    classification.valid?
    expect(classification.errors[:post]).to include('must exist')
  end

  it 'is invalid if there is no tag' do
    classification = FactoryBot.build(:classification, tag: nil)
    classification.valid?
    expect(classification.errors[:tag]).to include('must exist')
  end
end
