class Email < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :user_id, :email

	# -------------- Associations
	belongs_to :user

	# -------------- Validations	
	validates :user_id,  :presence => true
	validates :user_id,  :existence => true
	validates :email, :presence => true
	validates :email, :uniqueness => { :case_sensitive => false }
	validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

	# -------------- Custom Validations
	

end
