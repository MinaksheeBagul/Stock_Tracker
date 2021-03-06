class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      # as friendship table doesn't exist so will do references user 
      t.references :friend, references: :users, foreign_key: { to_table: :users}
      t.timestamps
    end
  end
end
