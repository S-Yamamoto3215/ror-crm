require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario 'user creates a new post' do
    user = FactoryBot.create(:user)
    sign_in user

    visit root_path

    expect {
      click_link 'Post List'
      click_link 'New post'
      fill_in 'Title', with: 'Test Title'
      fill_in 'Body', with: 'Test Content'
      fill_in 'Slug', with: 'test-slug'
      fill_in 'Tags (comma separated)', with: 'tag1, tag2, tag3'
      click_button 'Create Post'

      expect(page).to have_content 'Test Title'
      expect(page).to have_content 'Test Content'
    }.to change(user.posts, :count).by(1)
  end
end
