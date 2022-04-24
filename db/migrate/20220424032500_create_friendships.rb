class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      # Below is syntax for a self referencing
      # the Frienship table is actually a join table  between users and other users
      # through this psuedo table called "friend" which, we are telling Rails, actually points to the users table
      t.references :friend, refernces: :users, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
