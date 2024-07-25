class CommentsController < ApplicationController
  before_action :find_article, only: [:create]

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to article_path(@article) , notice: "Comment was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Comment was successfully created." }
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

end
