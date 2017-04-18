class CategoriesController < ApplicationController
  before_action :requrie_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = 'Category was created successfully'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      # use flash to pass some message to the very next action
      flash[:success] = 'the category is successfully editted'
      # after saving the category obj to DB
      # it would render someting to users
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private

  def category_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:category).permit(:name)
  end

  def requrie_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = 'Only admin could perform this action!'
      redirect_to categories_path
    end
  end
end
