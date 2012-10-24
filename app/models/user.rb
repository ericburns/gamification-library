class User < ActiveRecord::Base
	# Each attribute is required.
	validates :username, :presence => true

	# Username must be 3 > x > 40
	# => and unique (ignoring case)
	validates :username, :length => {:in => 3..40}
	validates :username, :uniqueness => {:case_sensitive => false}

	belongs_to :level
end