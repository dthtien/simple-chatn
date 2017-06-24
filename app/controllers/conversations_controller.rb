class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.all_conversations
  end

  def show
    @conversation = Conversation.includes(:messages).find(params[:id])
    @message = Message.new
    unless current_user.all_conversations.include?@conversation
      flash[:alert] = "Page not found"
      redirect_to root_path   
    end 
  end

  def create
    if current_user == params[:sender_id] || current_user == params[:receiver_id]
      @conversation = Conversation.find_or_create(params[:sender_id], params[:receiver_id])
      current_user.read_messages(@conversation)
      redirect_to @conversation
    else
      flash[:alert] = "Page not found"
      redirect_to root_path  
    end
  end
end
