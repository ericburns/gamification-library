class Level < ActiveRecord::Base

	validates :xp_to_next_level, :presence => true

	has_many :users
end