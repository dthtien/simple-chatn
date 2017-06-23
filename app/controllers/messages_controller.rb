class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation

  def create 
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
    if @message.save
      flash[:notice] = "Message was created!"
      redirect_to @conversation
    else
      flash.now[:alert] = "Can't create message"
      render :index
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
