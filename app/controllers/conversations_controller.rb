class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.includes(:messages).find(params[:id])
    @message = Message.new
  end

  def create
    @conversation = Conversation.find_or_create(params[:sender_id], params[:receiver_id])
    current_user.read_messages(@conversation)
    redirect_to @conversation
  end
end
