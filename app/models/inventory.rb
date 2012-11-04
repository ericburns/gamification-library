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
	validates_uniqueness_of :user_id, :scope => [:badge_id]
	validate :user_has_badge_already
	
	# -------------- Custom Validations
	
	def user_has_badge_already
		
		Inventory.where("user_id = ? AND badge_id = ?", user_id, badge_id).first_or_create!("amount = ?", amount)
		

	end
	

end
