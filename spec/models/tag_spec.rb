require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'is invalid if there is no name' do
    tag = FactoryBot.build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it 'is validif there is a name' do
    expect(FactoryBot.build(:tag)).to be_valid
  end

  it 'destroying a tag destroys its classifications' do
    tag = FactoryBot.create(:tag)
    3.times { tag.posts << FactoryBot.create(:post) }
    expect { tag.destroy }.to change { Classification.count }.by(-3)
  end
end
