class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.string :gamename, :null => false
    	t.string :description, :null => false
		t.timestamps
    end
  end
end
