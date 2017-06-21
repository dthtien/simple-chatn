class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: "sender_id", class_name: "User"
  belongs_to :receiver, foreign_key: "receiver_id", class_name: "User"
  has_many :messages, dependent: :destroy
  
  def self.find_or_create(sender_id, receiver_id)
    where("sender_id = ? AND receiver_id = ? OR receiver_id = ? AND sender_id = ?", sender_id, receiver_id, sender_id, receiver_id)
      .first_or_create do |conv|
      conv.sender_id = sender_id
      conv.receiver_id = receiver_id
    end
  end
end
