class AddChatIdToMessages < ActiveRecord::Migration[5.1]
  def change
     add_column :messages, :chat_id, :int
  end
end
