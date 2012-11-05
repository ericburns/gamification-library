class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	# A User's ID will be created automatically as "id" by Rails.
    	t.string :username, :null => false
    	t.integer :level_id, :null => false
    	t.integer :xp, :null => false, :default => 0
		t.string :encrypted_password
		t.string :salt
    	t.timestamps
    end

    add_index :users, :username, :unique => true
  end
end