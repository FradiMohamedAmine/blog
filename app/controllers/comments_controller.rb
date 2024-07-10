class CommentsController < ApplicationController
  before_action :find_article, only: [ :create ]
  before_action :find_comment, only: [ :like, :dislike ]

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

  def like
    @comment.increment!(:likes)
    broadcast_comment_update(@comment)
  end

  def dislike
    @comment.increment!(:dislikes)
    broadcast_comment_update(@comment)
  end

  private

  def broadcast_comment_update(comment)
    Turbo::StreamsChannel.broadcast_replace_to "comments",
      target: "comment_#{comment.id}",
      partial: "comments/comment",
      locals: { comment: comment }
  end

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
