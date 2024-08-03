module Api
  class CommentsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :authenticate_user!, only: [:create]
    before_action :find_article, only: [:create]

#POST /api/articles/:article_id/comments
    def create
      comment = @article.comments.build(comment_params)
      if comment.save
        render json: comment, status: :created, serializer: CommentSerializer
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end

    private

    def find_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
  end
end
