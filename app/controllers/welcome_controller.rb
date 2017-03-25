class WelcomeController < ApplicationController
  def home
    # can not see the home page (signup) if the user has logged in.
    redirect_to articles_path if logged_in?
  end

  def about
  end
end
