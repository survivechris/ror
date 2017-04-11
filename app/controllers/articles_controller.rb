class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
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
    @article.user = current_user
    if @article.save
      # use flash to pass some message to the very next action
      flash[:success] = 'the article is successfully created'
      # after saving the article obj to DB
      # it would render someting to users
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      # use flash to pass some message to the very next action
      flash[:success] = 'the article is successfully editted'
      # after saving the article obj to DB
      # it would render someting to users
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'the article is successfully deleted.'
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = 'You could only do the action in your article!'
      redirect_to root_path
    end
  end
end
