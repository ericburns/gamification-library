class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    	t.integer :user_id_1, :null => false
    	t.integer :user_id_2, :null => false
    	t.boolean :mutual, :null -> true, :default => false

    	t.timestamps
    end
  end
end
