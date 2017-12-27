class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, target=nil)
    ActionCable.server.broadcast "messages_#{message.chat_id}", message: render_message(message, target)
  end

  private

  def render_message(message, target=nil, current_user=nil)
    MessagesController.render partial: 'messages/message', locals: { message: message, target: target }
  end
end
