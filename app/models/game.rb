class Game < ActiveRecord::Base

	# -------------- Accessors/Mutators
	attr_accessible :gamename, :description
   
	# -------------- Associations
	has_many :users
					  
	# -------------- Validations  
	validates :gamename, :presence => true
	validates :gamename, :uniqueness => {:case_sensitive => false}
	validates :description, :presence => true
	
	# -------------- Custom Validations
	


end
