class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destoy]
  before_action :require_admin, only: [:destoy]

  def index
  	@users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # use flash to pass some message to the very next action
      flash[:success] = "Welcome to Cycle around Taiwan! #{@user.username}"
      # login upon signup
      session[:user_id] = @user.id
      # after saving the user obj to DB
      # it would render someting to users
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # use flash to pass some message to the very next action
      flash[:success] = 'your account is successfully updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = 'User and all associated articles are deleted.'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if !logged_in? || (current_user != @user && !current_user.admin?)
      flash[:danger] = 'You could only edit your own account!'
      redirect_to root_path
    end
  end

  def require_admin_user
    if !logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin could perform this action !'
      redirect_to root_path
    end
  end
end
