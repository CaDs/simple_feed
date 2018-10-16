class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email, index: true, unique: true
      t.string :username, index: true
      t.string :password
    end
  end
end
