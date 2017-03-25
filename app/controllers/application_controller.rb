class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= (User.find(session[:user_id]) if session[:user_id])
  end

  def logged_in?
    # it is the same as !!current_user
    !current_user.nil?
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'You must log in to perform this action!'
      redirect_to root_path
    end
  end
end
