class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
		t.string :badge_name, :null => false
		t.string :badge_image, :null => false, :default => "default.png"
		t.integer :awarded_at, :null => false, :default => 1
		t.text :badge_info
      t.timestamps
    end
  end
end
