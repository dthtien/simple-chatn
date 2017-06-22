class User < ApplicationRecord
  has_secure_password


  has_many :messages, foreign_key: "sender_id"
  has_many :conversations, through: :messages

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, 
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    uniqueness: true
  validates :password, presence: true, length: {maximum: 6}

  before_save :downcase_email

  def author?(message)
    message.sender == self
  end

  def all_conversations
    self.conversations.distinct
  end

  private
    def downcase_email
      self.email = email.downcase
    end
end
