class User < ApplicationRecord
  has_secure_password
  
  has_many :messages, foreign_key: "sender_id"
  has_many :conversations, through: :messages

  # Friendship relation
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, 
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    uniqueness: true
  validates :password, presence: true, length: {maximum: 6}

  before_save :downcase_email

  def author?(message)
    message.sender == self
  end

  def all_conversations_have_message
    self.conversations.distinct
  end

  def all_conversations
    Conversation.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end

  def read_messages(conversation)
    return if conversation.messages.blank?
    conversation.messages.where.not(sender_id: self.id).each do |message|
      message.update_attributes(read: true)
    end
  end

  def friend?(user)
    self.friends.include? user
  end

  def block?(user)
    self.friendships.find_by(friend_id: user.id).block
  end

  def befriend(user)
    return if self.friend?(user) 
    self.friends << user
    user.friends << self
  end

  def unfriend(user)
    return unless self.friend?(user) 
    Friendship.where("user_id=? AND friend_id=? or friend_id=? AND user_id=?", self.id, user.id, self.id, user.id).destroy_all
  end

  def block(user)
    return if self.block? user 
    Friendship.where("user_id=? AND friend_id=? or friend_id=? AND user_id=?", self.id, user.id, self.id, user.id).each do |friendship|
        friendship.update_attributes(block: true)
    end
  end

  def unblock(user)
    return unless self.block? user 
    Friendship.where("user_id=? AND friend_id=? or friend_id=? AND user_id=?", self.id, user.id, self.id, user.id).each do |friendship|
        friendship.update_attributes(block: false)
    end
  end

  private
    def downcase_email
      self.email = email.downcase
    end
end
