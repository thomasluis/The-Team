class DeleteBodyFromMessages < ActiveRecord::Migration[5.1]
  def change
     remove_column :messages, :body, :text

  end
end
