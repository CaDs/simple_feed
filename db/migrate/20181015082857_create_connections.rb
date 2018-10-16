class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.integer :follower_id, index: true, foreign_key: { to_table: :users }
      t.integer :following_id, index: true, foreign_key:  { to_table: :users }
      t.timestamps
    end
    add_index :connections, [:follower_id, :following_id], unique: true
  end
end
