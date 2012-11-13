class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.string :gamename, :null => false
    	t.text :description, :null => false
		t.string :unit, :null => false, :default => 'XP'
		t.timestamps
    end
  end
end
