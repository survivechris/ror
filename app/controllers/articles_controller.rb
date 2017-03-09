class ArticlesController < ApplicationController
  def index
    @all_articles = Article.all
  end

  def new
    @article = Article.new
  end

  # automatically redirect to create method
  # after new article is submitted
  def create
    # render plain: params[:article].inspect
    # get the article obj from article_para
    @article = Article.new(article_params)
    if @article.save
      # use flash to pass some message to the very next action
      flash[:notice] = 'the article is successfully created'
      # after saving the article obj to DB
      # it would render someting to users
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      # use flash to pass some message to the very next action
      flash[:notice] = 'the article is successfully editted'
      # after saving the article obj to DB
      # it would render someting to users
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private

  def article_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:article).permit(:title, :description)
  end
end
