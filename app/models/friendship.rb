class Friendship < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :user_id, :friend_id

	# -------------- Associations
	belongs_to :user
	belongs_to :friend, :class_name => "User", :foreign_key => 'friend_id'

	# -------------- Validations
	validates :user_id, :existence => true
	validates :friend_id, :existence => true
	validate :user_cannot_friend_self
	validate :friendship_does_not_exist
	
	# -------------- Custom Validation Methods
	def user_cannot_friend_self
		if user_id == friend_id
			errors.add(:friend_id, "cannot be the same as the user_id.")
		end
	end

	def friendship_does_not_exist
		if Friendship.where("user_id = ? AND friend_id = ?", user_id, friend_id).exists?
			errors.add(:friend_id, "is aleady a friend.")
		end
	end
end