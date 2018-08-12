class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :my]

  def index
    @articles = Article.all
  end

  def my
    @articles = current_user.articles
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit
    block_action if not_author? @article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if not_author? @article
      block_action
    elsif @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if not_author? @article
      block_action
    else
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :language, :content)
  end

  def not_author?(article)
    article.user != current_user
  end

  def block_action
    redirect_back(fallback_location: root_path, notice: 'Only author can do this action.')
  end
end
