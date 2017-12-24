class AddNameToChats < ActiveRecord::Migration[5.1]
  def change
    add_column :chats, :name, :string
  end
end
