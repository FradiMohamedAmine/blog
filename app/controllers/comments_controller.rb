class CommentsController < ApplicationController
  before_action :find_article, only: [:create]
  before_action :find_comment, only: [:like, :dislike]

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to article_path(@article) }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("comments", @comment) }
      end
    else
      render :new
    end
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
