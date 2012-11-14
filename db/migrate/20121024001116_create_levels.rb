class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
    	t.string :game_id, :null => false
    	t.integer :xp_to_next_level, :null => false, :default => -1
 
    	t.timestamps
    end
  end
end