require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    it 'responds successfully' do
      get :index

      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#show' do
    context 'as an authorized user' do
      include_context 'post setup'

      it 'responds successfully' do
        sign_in user
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end
    end

    context 'as an unauthorized user' do
      include_context 'post setup'

      it 'redirects to the sign-in page' do
        get :show, params: { id: post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      let(:user) { FactoryBot.create(:user) }

      context 'with valid attributes' do
        it 'adds a post' do
          post_params = FactoryBot.attributes_for(:post)
          sign_in user
          expect {
            post :create, params: { post: post_params }
          }.to change(user.posts, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not add a post' do
          post_params = FactoryBot.attributes_for(:post, :invalid)
          sign_in user
          expect {
            post :create, params: { post: post_params }
          }.to_not change(user.posts, :count)
        end
      end
    end

    context 'as an unauthorized user' do
      it 'returns a 302 response' do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    context 'as an authorized user' do
      include_context 'post setup'

      it 'updates a post' do
        post_params = FactoryBot.attributes_for(:post, title: 'New post content')
        sign_in user
        patch :update, params: { id: post.id, post: post_params }
        expect(post.reload.title).to eq 'New post content'
      end

      it 'redirects to the post show page' do
        post_params = FactoryBot.attributes_for(:post, title: 'New post content')
        sign_in user
        patch :update, params: { id: post.id, post: post_params }
        expect(response).to redirect_to post_path(post)
      end
    end

    context 'as an unauthorized user' do
      include_context 'post setup'

      it 'does not update the post' do
        post_params = FactoryBot.attributes_for(:post, title: 'New post content')
        patch :update, params: { id: post.id, post: post_params }
        expect(post.reload.title).not_to eq 'New post content'
      end

      it 'redirects to the sign-in page' do
        post_params = FactoryBot.attributes_for(:post, title: 'New post content')
        patch :update, params: { id: post.id, post: post_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it 'deletes a post' do
        sign_in @user
        expect {
          delete :destroy, params: { id: @post.id }
        }.to change(@user.posts, :count).by(-1)
      end

      it 'redirects to the posts index page' do
        sign_in @user
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to posts_path
      end
    end

    context 'as an unauthorized user' do
      before do
        @post = FactoryBot.create(:post)
      end

      it 'does not delete the post' do
        expect {
          delete :destroy, params: { id: @post.id }
        }.to_not change(Post, :count)
      end

      it 'redirects to the sign-in page' do
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
