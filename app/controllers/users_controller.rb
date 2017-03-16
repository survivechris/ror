class UsersController < ApplicationController
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

  private

  def user_params
    # sanitize user input by #ActionController::Parameters.require
    # and permit method
    params.require(:user).permit(:username, :email, :password)
  end
end
