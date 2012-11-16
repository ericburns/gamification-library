class Level < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :xp_to_next_level, :game_id, :levelno
	default_scope order('levelno ASC, xp_to_next_level ASC')

	# -------------- Associations
	belongs_to :game

	# -------------- Callbacks
	after_save :enforce_sequential_levels

	# -------------- Validations
	before_save :enforce_sequential_levels
	validates :xp_to_next_level, :presence => true
	validates :xp_to_next_level, :numericality => {:greater_than => 0}
	validate :xp_higher_than_previous_level_xp
	validates :game_id, :existence => true
	validates :levelno, :numericality => {:greater_than => 0}
	validates_uniqueness_of :game_id, :scope => [:levelno]

	# -------------- Custom Validation Methods
	def xp_higher_than_previous_level_xp
		game_levels = Level.where("game_id = ?", :game_id)
        game_levels.order("levelno")
        last = game_levels.find(:last)
		if last != nil && last.xp_to_next_level >= xp_to_next_level
				errors.add(:xp_to_next_level, "is lower or equal to previous level's experience.")
		end
	end
	
	def assign_levelno
		game_levels = Level.where("game_id = ?", game_id)
        game_levels.order("levelno")
        last = game_levels.find(:last)
		#@lastno = last.levelno + 1
		self.levelno = last.levelno + 1
	
	end
	
	def enforce_sequential_levels
		game_levels = Level.where("game_id = ?", game_id)
        game_levels.order('levelno ASC, xp_to_next_level ASC')
		#game_levels.order('xp_to_next_level ASC')
		howmanylevels = game_levels.count
		
		lastlevel = 1
		if (howmanylevels > 0)
			game_levels.each do |level|
			thislevel = level
				if (thislevel.levelno != lastlevel + 1 && thislevel.levelno > 1) 
					thislevel.levelno = lastlevel + 1
				end
			
			lastlevel = level.levelno
			end	
		
		end
		self.levelno = lastlevel
		
		
	end
	
end