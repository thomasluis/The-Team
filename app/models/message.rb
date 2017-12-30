class Message < ApplicationRecord
   include AttachmentUploader[:attachment]
   belongs_to :user

   belongs_to :chat

   attr_accessor :target_to_msg, :current_user

   # validates :body, presence: true, unless: :attachment_data

   validates :content, presence: true, unless: :attachment_data

   after_create_commit :broadcast_message


   # virtual attributes for temp storage of attachment's original name
   def attachment_name=(name)
      @attachment_name = name
   end

   def attachment_name
      @attachment_name
   end

   private

   def broadcast_message
      target = self.target_to_msg.presence
      current_user = self.user
      MessageBroadcastJob.perform_later(self, target, current_user)
   end
end
