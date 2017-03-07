class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  # automatically redirect to create method
  # after new article is submitted
  def create
    render plain: params[:article].inspect
    # get the article obj from article_para
    @article = Article.new(article_params)
    @article.save
    # after saving the article obj to DB
    # it would render someting to users
    redirect_to article_show(@article)
  end

  private

  def article_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:article).permit(:title, :description)
  end
end
