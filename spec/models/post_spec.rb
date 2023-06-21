require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid if there is a title and body' do
    post = Post.new(title: 'My Title', body: 'My Body. My Body')
    expect(post).to be_valid
  end

  it 'is invalid if there is no title' do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid if there is no body' do
    post = Post.new(body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end

  context 'Title character limit of between 5 and 50 characters' do
    it 'is valid if the title is 5 characters' do
      post = Post.new(title: 'a' * 5)
      post.valid?
      expect(post.errors[:title]).to be_empty
    end

    it 'is valid if the title is 50 characters' do
      post = Post.new(title: 'a' * 50)
      post.valid?
      expect(post.errors[:title]).to be_empty
    end

    it 'is valid if the title is 25 characters' do
      post = Post.new(title: 'a' * 25)
      post.valid?
      expect(post.errors[:title]).to be_empty
    end

    it 'is invalid if the title is 4 characters' do
      post = Post.new(title: 'a' * 4)
      post.valid?
      expect(post.errors[:title]).to_not be_empty
    end

    it 'is invalid if the title is 51 characters' do
      post = Post.new(title: 'a' * 51)
      post.valid?
      expect(post.errors[:title]).to_not be_empty
    end

    it 'is invalid if the title is blank' do
      post = Post.new(title: '  ')
      post.valid?
      expect(post.errors[:title]).to_not be_empty
    end
  end

  context 'Minimum word limit of 10 characters in the Body' do
    it 'is valid if the body is 10 characters' do
      post = Post.new(body: 'a' * 10)
      post.valid?
      expect(post.errors[:body]).to be_empty
    end

    it 'is valid if the body is 100 characters' do
      post = Post.new(body: 'a' * 100)
      post.valid?
      expect(post.errors[:body]).to be_empty
    end

    it 'is invalid if the body is 9 characters' do
      post = Post.new(body: 'a' * 9)
      post.valid?
      expect(post.errors[:body]).to_not be_empty
    end

    it 'is invalid if the title is blank' do
      post = Post.new(body: '  ')
      post.valid?
      expect(post.errors[:body]).to_not be_empty
    end
  end
end
