class CommentsController < ApplicationController
  before_action :find_article, only: [ :new, :create ]

  def new
    @comment = @article.comments.build
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@article) }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("comments", @comment) }
      else
        format.html { render "new" }
      end
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
