class Badge < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :badge_name, :badge_image, :badge_info
	
	# -------------- Associations
	has_many :inventories

	# -------------- Validations  
	validates :badge_name,  :presence => true
	validates :badge_name, :uniqueness => {:case_sensitive => false }
	validates :badge_image,  :presence => true
	
end
