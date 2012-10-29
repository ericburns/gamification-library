class User < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :username, :level_id, :xp

	# -------------- Associations
	belongs_to :level
	has_many :friendships
	has_one :inventory
	has_many :emails

	# -------------- Validations
	validates :username, :presence => true
	validates :username, :length => {:in => 3..40}
	validates :username, :uniqueness => {:case_sensitive => false}
	validates :level_id, :existence => true
	validates :xp, :numericality => {:greater_than_or_equal_to => 0}
end