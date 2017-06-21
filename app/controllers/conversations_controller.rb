class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.includes(:messages).find(params[:id])
    @message = Message.new
  end

  def create
    @conversation = Conversation.find_or_create(current_user.id, params[:receiver_id])
    redirect_to conversation_messages_path(@conversation)
  end
end
