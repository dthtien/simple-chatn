class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_friend
  def add_friend
    if current_user.befriend(@friend)
      flash[:notice] = "Added!"
    else
      flash[:notice] = "Cannot create"
    end
    redirect_to users_path
  end

  def unfriend
    current_user.unfriend(@friend)
    flash[:notice] = "#{@friend.name} now is not your friend"
    redirect_to users_path
  end

  def block
    current_user.block(@friend)
    flash[:notice] = "#{@friend.name} now has beed blocked"
    redirect_to users_path
  end

  def unblock
    current_user.unblock(@friend)
    flash[:notice] = "#{@friend.name} now has beed unblocked"
    redirect_to users_path
  end

  private
    def find_friend
      @friend = User.find(params[:friend_id])
    end
end
