class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation

  def create 
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
    if @message.save
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def message_params
      params.require(:message).permit(:content)  
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end
