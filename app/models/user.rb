class User < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessor :username, :password, :password_confirmation, level_id, :xp

	# -------------- Associations
	belongs_to :level
	has_many :friendships
	has_many :inventory
	has_many :emails
	
	# -------------- Callbacks
	before_save :encrypt_password
	after_save :clear_password

	# -------------- Validations
	validates :username, :presence => true
	validates :username, :length => {:in => 3..40}
	validates :username, :uniqueness => {:case_sensitive => false}
	validates :level_id, :existence => true
	validates :xp, :numericality => {:greater_than_or_equal_to => 0}
	validates :password, :confirmation => true #Password confirmation done here
	validates_length_of :password, :in => 6..20, :on => :create
	
	# -------------- Custom Callbacks
	
		def encrypt_password
	if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end
	
end
end