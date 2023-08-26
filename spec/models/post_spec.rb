require 'rails_helper'

RSpec.describe Post, type: :model do
  user = FactoryBot.create(:user)

  it 'is valid' do
    expect(FactoryBot.build(:post, user:)).to be_valid
  end

  it 'is invalid if there is no title' do
    post = FactoryBot.build(:post, title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid if there is no body' do
    post = FactoryBot.build(:post, body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end

  it 'is invalid if there is no slug' do
    post = FactoryBot.build(:post, slug: nil)
    post.valid?
    expect(post.errors[:slug]).to include("can't be blank")
  end

  it 'is invalid if the slug is not unique' do
    FactoryBot.create(:post, slug: 'my-title')
    post = FactoryBot.build(:post, slug: 'my-title')
    post.valid?
    expect(post.errors[:slug]).to include('has already been taken')
  end

  it 'is valid if the title is 5 characters' do
    post = FactoryBot.build(:post, title: 'a' * 5)
    post.valid?
    expect(post.errors[:title]).to be_empty
  end

  it 'is valid if the title is 50 characters' do
    post = FactoryBot.build(:post, title: 'a' * 50)
    post.valid?
    expect(post.errors[:title]).to be_empty
  end

  it 'is valid if the title is 25 characters' do
    post = FactoryBot.build(:post, title: 'a' * 25)
    post.valid?
    expect(post.errors[:title]).to be_empty
  end

  it 'is invalid if the title is 4 characters' do
    post = FactoryBot.build(:post, title: 'a' * 4)
    post.valid?
    expect(post.errors[:title]).to_not be_empty
  end

  it 'is invalid if the title is 51 characters' do
    post = FactoryBot.build(:post, title: 'a' * 51)
    post.valid?
    expect(post.errors[:title]).to_not be_empty
  end

  it 'is invalid if the title is blank' do
    post = FactoryBot.build(:post, title: '  ')
    post.valid?
    expect(post.errors[:title]).to_not be_empty
  end

  it 'is valid if the body is 10 characters' do
    post = FactoryBot.build(:post, body: 'a' * 10)
    post.valid?
    expect(post.errors[:body]).to be_empty
  end

  it 'is valid if the body is 100 characters' do
    post = FactoryBot.build(:post, body: 'a' * 100)
    post.valid?
    expect(post.errors[:body]).to be_empty
  end

  it 'is invalid if the body is 9 characters' do
    post = FactoryBot.build(:post, body: 'a' * 9)
    post.valid?
    expect(post.errors[:body]).to_not be_empty
  end

  it 'is invalid if the title is blank' do
    post = FactoryBot.build(:post, body: '  ')
    post.valid?
    expect(post.errors[:body]).to_not be_empty
  end

  it 'destroys associated classifications' do
    post = FactoryBot.create(:post)
    3.times { post.tags << FactoryBot.create(:tag) }
    expect { post.destroy }.to change { Classification.count }.by(-3)
  end
end
