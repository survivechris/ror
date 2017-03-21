class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user = User.new(user_params)

    if @user.save
      # use flash to pass some message to the very next action
      flash[:success] = 'Welcome to Cycle around Taiwan!'
      # after saving the user obj to DB
      # it would render someting to users
      redirect_to articles_path
    else
      render 'new'
    end
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


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:user).permit(:username, :email, :password)
  end
end