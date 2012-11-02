class Inventory < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :user_id, :badge_id, :amount
   
	# -------------- Associations
	belongs_to :user
	belongs_to :badge
					  
	# -------------- Validations  
	validates :user_id, :existence => true
	validates :user_id, :presence => true
	validates :badge_id, :existence => true
	validates :badge_id, :presence => true
	validates :amount, :numericality => true
	validates :amount, :numericality => { :only_integer => true }
	validates :amount, :numericality => {:greater_than => 0}
	validate :user_has_badge_already
	
	# -------------- Custom Validations
	
	def user_has_badge_already
		
		if Inventory.where("user_id = ? AND badge_id = ?", user_id, badge_id).exists?
			errors.add(:user_id, "has this badge. If you were trying to increment the amount of this badge to this user, lock the row with the correct user_id/badge_id combination and then increment :amount.")
		end
		
		#I was able to increment the number of badges a user has by doing the following in the rails console.
		
		#Select the inventory where user_id is 1 and badge_id is 1.
		#i = Inventory.lock.where(:user_id => '1', :badge_id => '1')
		
		#Lock down i and send it to k. I read it on one of the ruby guide pages and it worked.
		#k = i.lock.first
		
		#Increments the value in :amount by 1. You could put it in a loop just in case the user wants to increment by any number.
		#k.increment!(:amount) 
		

	end
	

end
