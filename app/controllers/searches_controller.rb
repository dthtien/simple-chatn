class SearchesController < ApplicationController
  before_action :authenticate_user!

  def show
    @search = Search.new(params[:search])

    render json: @search.users.distinct.each_with_object({}) { |user, h|
      h[user.name] ={receiver_id: user.id, sender_id: current_user.id}
    }
  end
end
