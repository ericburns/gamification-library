class Level < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :xp_to_next_level, :game_id, :levelno
	default_scope order('levelno ASC')

	# -------------- Associations
	belongs_to :game

	# -------------- Callbacks
	after_save :enforce_sequential_levels

	# -------------- Validations
	validates :xp_to_next_level, :presence => true
	validates :xp_to_next_level, :numericality => {:greater_than => 0}
	validate :xp_higher_than_previous_level_xp
	validates :game_id, :existence => true
	validates :levelno, :numericality => {:greater_than => 0}
	validates_uniqueness_of :game_id, :scope => [:levelno]

	# -------------- Custom Validation Methods
	def xp_higher_than_previous_level_xp
		#laster = Level.where("game_id = ?", :game_id)
		laster = Level.where("game_id = ?", :game_id)
		laster.order("levelno")
		last = laster.find(:last)
		#last = Level.find(:last)
		if last != nil && last.xp_to_next_level >= xp_to_next_level
				errors.add(:xp_to_next_level, "is lower or equal to previous level's experience.")
		end
	end
	
	def assign_levelno
		gamelevels = Level.find(self.game_id).game.levels
	    gamelevels.order('levelno')
		howmanylevels = gamelevels.count
		levelno = howmanylevels + 1
	
	end
	
	def enforce_sequential_levels
		gamelevels = Level.where("game_id = ?", :game_id)
		gamelevels.order('levelno')
		howmanylevels = Level.find(self.game_id).count
		
		lastlevel = 1
		if (howmanylevels > 0)
			gamelevels.each do |level|
			thislevel = level
				if (thislevel.levelno != lastlevel + 1 && thislevel.levelno > 1) 
					thislevel.levelno = lastlevel + 1
				end
			
			lastlevel = level.levelno
			end	
		
		end
		
	end
	
end