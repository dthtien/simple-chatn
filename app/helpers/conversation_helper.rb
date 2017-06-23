module ConversationHelper
  def show_name(conversation)
    current_user == conversation.sender ? conversation.receiver.name : conversation.sender.name
  end
end
