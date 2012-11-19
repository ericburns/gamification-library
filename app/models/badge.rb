class Badge < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :game_id, :badge_name, :badge_image, :badge_info, :awarded_at
	
	# -------------- Associations
	belongs_to :game
	has_many :inventories, :dependent => :destroy

	# -------------- Validations  
	validates :badge_name,  :presence => true
	validates :badge_name, :uniqueness => {:case_sensitive => false }
	validates :badge_image,  :presence => true
	validates :awarded_at,  :presence => true
	validates :game_id, :existence => true
	
end
