class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.timestamps

      t.references :user, index: true, foreign_key: true
      t.string :message
    end
  end
end
