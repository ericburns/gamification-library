class User < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :username, :game_id, :level_id, :xp, :password_confirmation, :email, :salt, :password
  attr_accessor :password
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

	# -------------- Associations
	belongs_to :level
	belongs_to :game
	has_many :friendships
	has_many :inventory
	has_many :emails
	
	# -------------- Callbacks
	before_save :encrypt_password
	before_save :adjust_level
	after_save :clear_password

	# -------------- Validations
	validates :username, :presence => true
	validates :username, :length => {:in => 3..40}
	validates :username, :uniqueness => {:case_sensitive => false}
	validates :game_id, :existence => true
	validates :xp, :numericality => {:greater_than_or_equal_to => 0}
	validates :password, :confirmation => true #Password confirmation done here
	validates_length_of :password, :in => 6..20, :on => :create
	
	# -------------- Custom Callbacks
	
	def encrypt_password
		if password.present?
			self.salt= Digest::SHA1.hexdigest("# We add {email} as unique value and #{Time.now} as random value")
			self.encrypted_password= Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
		end
	end

	def clear_password
		self.password = nil
	end
	
  def self.authenticate(username_or_email = "", login_password = "")
    user = User.find_by_username(username_or_email)

	#I think there's some unnecessary lines here, but we can clean this up later. - CW
	
    if EMAIL_REGEX.match(username_or_email)
        user = Email.find_by_email(username_or_email).user
    else
        user = User.find_by_username(username_or_email)
    end

      return user if user && user.match_password(login_password)
      return false
  end

  def match_password(login_password = "")
    self.encrypted_password == Digest::SHA1.hexdigest("Adding #{salt} to #{login_password}")
  end

  def adjust_level
  	self.level_id = 1
  	Level.all.each do |level|
  		if xp >= level.xp_to_next_level
  			self.level_id = level.id + 1 unless !Level.exists?(level.id + 1)
  		end
  	end
  end
end