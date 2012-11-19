class User < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :username, :game_id, :xp, :password_confirmation, :email, :salt, :password
  attr_accessor :password
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

	# -------------- Associations
	belongs_to :game
	has_many :friendships
	has_many :inventory, :dependent => :destroy
	has_many :emails, :dependent => :destroy
	
	# -------------- Callbacks
	before_save :encrypt_password
	after_save :clear_password, :give_badge

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

  def give_badge
		User.all.each do |user|		
			userr = User.find(user.id)
			atlevel = userr.level.levelno 
			
			Badge.all.each do |badge|
				badger = Badge.find(badge.id)

					if (badger.game_id == userr.game_id)
						if (atlevel == badger.awarded_at)

						Inventory.where(:user_id => userr.id, :badge_id => badger.id).first_or_create(amount: 1)
						
						end
					end			
			end
		end  
  end
  
  def level
  	levels = User.find(self.id).game.levels
	levels.order('levelno ASC')
	
  	if (levels.count == 0)
  		return Level.create(xp_to_next_level: 0, levelno: 1) #I think this is broken - Cooper.
  	end

	user_level = 1
	strike = 0
	levid = levels.find(:first).id
  	levels.each do |level|
		if (strike < 1 && user_level < levels.count)
			if (xp >= level.xp_to_next_level)
				user_level += 1
				levid = level.id
				
			else (xp < level.xp_to_next_level)
				strike += 1
				user_level += 1
				levid = level.id
			end
		end
  	end
	

	return levels.find(levid)

  end
  	
end