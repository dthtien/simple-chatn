class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Hello #{user.name}"
      log_in(user)
      conversations = user.all_conversations
      redirect_to conversations.blank? ? root_path : conversations.first
    else
      flash.now[:alert] = "Please check your email and password"
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = "Goodbye!"
    redirect_to root_path
  end
end
