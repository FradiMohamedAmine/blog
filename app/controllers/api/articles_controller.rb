module Api
  class ArticlesController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :authenticate_user!, only: [:index, :show,:create,:update,:destroy]

    before_action :find_article, only: [:show, :update, :destroy]

    # GET /api/articles
    def index
      articles = Article.all
      render json: articles, each_serializer: ArticleSerializer
    end

    # GET /api/articles/:id
    def show
      render json: @article, serializer: ArticleSerializer
    end

    # POST /api/articles
    def create
      article = Article.new(article_params)
      if article.save
        render json: article, status: :created, serializer: ArticleSerializer
      else
        render json: article.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/articles/:id
    def update
      if @article.update(article_params)
        render json: @article, serializer: ArticleSerializer
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/articles/:id
    def destroy
      @article.destroy
      render json: { messages: ["Article destroyed successfully"] }, status: :ok
    end

    private

    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
end
