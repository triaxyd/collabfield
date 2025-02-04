class CreateGroupConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :group_conversations do |t|
      t.timestamps
    end
  end
end
