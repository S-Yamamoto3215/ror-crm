require 'rails_helper'

RSpec.describe "Posts API", type: :request do
  it 'loads a post' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, title: 'A test post', user:)

    get posts_path, headers: { ACCEPT: 'application/json' }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 1
  end
end
