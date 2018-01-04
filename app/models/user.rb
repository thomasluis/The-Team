class User < ApplicationRecord
  include Clearance::User
  # mount_uploader :avatar, AvatarUploader

  has_many :messages, dependent: :destroy
  has_many :subscriptions
  has_many :chats, through: :subscriptions

  # validates_presence_of   :avatar
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

  def existing_chats_users
    existing_chat_users = []
    self.chats.each do |chat|
    existing_chat_users.concat(chat.subscriptions.where.not(user_id: self.id).map {|subscription| subscription.user})
    end
    existing_chat_users.uniq
  end

  def self.search(term)
     if term
        where('username LIKE ?', "%#{term}%")
     else
        all
     end
  end

end
