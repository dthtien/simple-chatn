class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  protected
    def authenticate_user!
      unless logged_in?
        flash[:alert] = "Login to continue"
        redirect_to root_path
      end
    end
end
