class AddIdentifierToChats < ActiveRecord::Migration[5.1]
  def change
    add_column :chats, :identifier, :string
  end
end
