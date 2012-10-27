class Level < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :xp_to_next_level

	# -------------- Associations
	has_many :users

	# -------------- Validations
	validates :xp_to_next_level, :presence => true
	validates :xp_to_next_level, :numericality => {:greater_than => 0}
	validate :xp_higher_than_previous_level_xp

	# -------------- Custom Validation Methods
	def xp_higher_than_previous_level_xp
		last = Level.find(:last)
		if last != nil && last.xp_to_next_level >= xp_to_next_level
				errors.add(:xp_to_next_level, "is lower or equal to previous level's experience.")
		end
	end
end