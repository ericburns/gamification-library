class Admin < ActiveRecord::Base

    # -------------- Accessors/Mutators
    attr_accessible :username, :password_confirmation, :email, :salt, :password
  attr_accessor :password
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

    # -------------- Associations
    has_many :emails, :dependent => :destroy
    
    # -------------- Callbacks
    before_save :encrypt_password
    after_save :clear_password

    # -------------- Validations
    validates :username, :presence => true
    validates :username, :length => {:in => 3..40}
    validates :username, :uniqueness => {:case_sensitive => false}
    validate :check_for_name_in_users_table
    validates :password, :confirmation => true #Password confirmation done here
    validates_length_of :password, :in => 6..20, :on => :create
    
    # -------------- Custom Callbacks

    # snagged from user.rb
    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

    def encrypt_password
        if password.present?
            self.salt= Digest::SHA1.hexdigest("# We add {email} as unique value and #{Time.now} as random value")
            self.encrypted_password= Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
        end
    end

    def clear_password
        self.password = nil
    end

    def match_password(login_password = "")
        self.encrypted_password == Digest::SHA1.hexdigest("Adding #{salt} to #{login_password}")
    end

    def self.authenticate(username_or_email = "", login_password = "")
        # shortened this to a one liner
        user = (EMAIL_REGEX.match(username_or_email) ? Email.find_by_email(username_or_email).admin : Admin.find_by_username(username_or_email))

        return user if user && user.match_password(login_password)
        return false
    end

    def check_for_name_in_users_table
        errors.add(:username, "has already been taken") if User.find_by_username(self.username)
        
    end

end
