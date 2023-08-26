# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Factoryが有効であることを確認する
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # Deviseのデフォルトのバリデーション
  # （これは一例です。具体的な要件に応じてテストを追加・修正する必要があります）
  it 'requires an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'requires a password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

  # 関連性
  it 'can have many posts' do
    user = FactoryBot.create(:user)
    post1 = FactoryBot.create(:post, user:)
    post2 = FactoryBot.create(:post, user:)

    expect(user.posts).to include(post1, post2)
  end

  # 依存オプション
  it 'deletes related posts when deleted' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user:)

    expect { user.destroy }.to change { Post.count }.by(-1)
  end
end
