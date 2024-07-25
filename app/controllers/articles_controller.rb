class ArticlesController < ApplicationController
  def index
    @articles = Article.ordered
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.ordered
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      respond_to do |format|
        format.html { redirect_to articles_path , notice: "Article was successfully created." }
        format.turbo_stream{ flash.now[:notice] = "Article was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to articles_path , notice: "Article was successfully updated." }
        format.turbo_stream{ flash.now[:notice] = "Article was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html  { redirect_to articles_path , notice: "Article was successfully deleted." }
      format.turbo_stream{ flash.now[:notice] = "Article was successfully deleted." }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
