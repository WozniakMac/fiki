require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:test_user) { create(:user) }

  let(:valid_attributes) { attributes_for(:article, user_id: test_user.id) }

  let(:invalid_attributes) do
    attributes_for(:article, title: nil, language: nil, content: nil, user_id: test_user.id)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Article.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #my' do
    context 'when user signed in' do
      it 'returns a success response' do
        sign_in test_user
        Article.create! valid_attributes
        get :my, params: {}
        expect(response).to be_successful
      end
    end

    context 'when user not signed in' do
      it 'returns a success response' do
        Article.create! valid_attributes
        get :my, params: {}
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      article = Article.create! valid_attributes
      get :show, params: { id: article.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      sign_in test_user
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in test_user
      article = Article.create! valid_attributes
      get :edit, params: { id: article.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Article' do
        sign_in test_user
        expect do
          post :create, params: { article: valid_attributes }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        sign_in test_user
        post :create, params: { article: valid_attributes }
        expect(response).to redirect_to(Article.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        sign_in test_user
        post :create, params: { article: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'redirects to the article' do
        sign_in test_user
        article = Article.create! valid_attributes
        put :update, params: { id: article.to_param, article: valid_attributes }
        expect(response).to redirect_to(article)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        sign_in test_user
        article = Article.create! valid_attributes
        put :update, params: { id: article.to_param, article: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested article' do
      sign_in test_user
      article = Article.create! valid_attributes
      expect do
        delete :destroy, params: { id: article.to_param }
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      sign_in test_user
      article = Article.create! valid_attributes
      delete :destroy, params: { id: article.to_param }
      expect(response).to redirect_to(articles_url)
    end
  end
end
