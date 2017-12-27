class MessagesController < ApplicationController

   def index
      @chat = current_user.chats.find_by_id(params[:chat_id])
      @target = params[:target].presence || "en"
      respond_to do |format|
         format.html { render partial: 'messages/message', collection: @chat.messages.order(id: :asc) }
      end
   end

   def create
      message = Message.new(message_params)
      message.user = current_user

      if message.save
         message.target_to_msg = message_params[:target_to_msg]
         #broadcasting out to messages channel including the chat_id so messages are broadcasted to specific chat only
         # ActionCable.server.broadcast( "messages_#{message_params[:chat_id]}",
         #    #message and user hold the data we render on the page using javascript
         #    message: message.content,
         #    user: message.user.username
         # )
      else
         redirect_to user_chats_path
      end
   end
   private
   def message_params
      params.require(:message).permit(:content, :chat_id, :user_id, :attachment, :target_to_msg)
   end
end
