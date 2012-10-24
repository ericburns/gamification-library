class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	# A User's ID will be created automatically as "id" by Rails.
    	t.string :username, :null => false
    	t.integer :level_id, :null => false
    	t.integer :xp, :null => false, :default => 0

    	t.timestamps
    end
  end
end