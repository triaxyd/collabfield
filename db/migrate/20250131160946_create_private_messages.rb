class CreatePrivateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :private_messages do |t|
      t.timestamps
    end
  end
end
