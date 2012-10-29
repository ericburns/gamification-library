class Email < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :user_id, :email

	# -------------- Associations
	belongs_to :user

	# -------------- Validations	
	validates :user_id,  :presence => true
	validates :user_id,  :existence => true
	validates :email, :presence => true
	validates :email, :uniqueness => { :case_sensitive => false }
 

end
