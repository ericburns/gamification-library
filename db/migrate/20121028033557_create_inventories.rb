class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
		t.string :user_id, :null => false
		t.string :badge_id, :null => false
		t.integer :amount
      t.timestamps
    end
  end
end
