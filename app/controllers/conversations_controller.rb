class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_in_conversation, only: :show

  def index
    @conversations = current_user.all_conversations
  end

  def show
    @message = Message.new
  end

  def create
    @conversation = Conversation.find_or_create(params[:sender_id], params[:receiver_id])
    current_user.read_messages(@conversation)
    redirect_to @conversation
  end

  private
    def user_is_in_conversation
      @conversation = Conversation.includes(:messages).find(params[:id])
      unless current_user.all_conversations.include? @conversation
        flash[:alert] = "Page not found"
        redirect_to root_path
      end
    end
end
