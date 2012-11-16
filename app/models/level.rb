class Level < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :xp_to_next_level, :game_id, :levelno
	#default_scope order('levelno ASC, xp_to_next_level ASC')
	default_scope order('xp_to_next_level ASC')

	# -------------- Associations
	belongs_to :game

	# -------------- Callbacks
	#after_save :levelsync #:enforce_sequential_levels #, :levelsync
	#after_save :givelevelno

	# -------------- Validations
	validate :givelevelno
	validate :enforce_sequential_levelss
	validates :xp_to_next_level, :presence => true
	validates :xp_to_next_level, :numericality => {:greater_than => 0}
	#validate :xp_higher_than_previous_level_xp
	validates :game_id, :existence => true
	validates :levelno, :numericality => {:greater_than => 0}
	#validates_uniqueness_of :levelno, :scope => [:game_id]

	# -------------- Custom Validation Methods
	def xp_higher_than_previous_level_xp
		game_levels = Level.where("game_id = ?", :game_id)
        game_levels.order("levelno")
        last = game_levels.find(:last)
		if last != nil && last.xp_to_next_level >= xp_to_next_level
				errors.add(:xp_to_next_level, "is lower or equal to previous level's experience.")
		end
	end
	
	def givelevelno
	
		game_levels = Level.where("game_id = ?", game_id)
		
		if (game_levels.count > 0)
        game_levels.order('levelno')
        last = game_levels.find(:last)
		self.levelno = last.levelno + 1
		
		else
		self.levelno = 1
		
		end
		
	
	end
	
	
	def levelsync
	
		game_levels = Level.where("game_id = ?", game_id)
		#game_levels = Level.find(self.game_id).game.levels
		#game_levels = Level.find(self.game_id)
		#game_levels = game_levels.order('xp_to_next_level ASC')
		howmanylevels = game_levels.count
		print "HEY FUCKER"
		print howmanylevels
		lastlevel = 0
		if (game_levels.count > 0)
		
			game_levels.each do |level|

			lastlevel += 1
			print level.levelno
			print " ??     "
			print lastlevel
			print "      "
			thislevel = level
			level.levelno = lastlevel

			
			end

		end

	end
	
	def enforce_sequential_levelss
		game_levels = Level.where("game_id = ?", game_id)
        #game_levels.order('levelno ASC, xp_to_next_level ASC')
		game_levels = game_levels.order('xp_to_next_level ASC')
		howmanylevels = game_levels.count
		
		print howmanylevels
		print "MEGA COCK!!!!!!!"
		lastlevel = 0
		foundself = false
		if (howmanylevels > 0)
			game_levels.each do |level|
			thislevel = level
			
				if (foundself == false)
				
					if	(self.xp_to_next_level > thislevel.xp_to_next_level)
						thislevel.levelno = lastlevel + 1
						print "!!!!!!!!!!!!!!!!!!!!!!!!??????????!"
						print thislevel.levelno
					else
					print "OHSHITSON"
				
					 self.levelno = lastlevel + 1
					 print self.levelno
					  print "OHSHITSON"
					  
					 thislevel.levelno = lastlevel + 2 
					 print thislevel.levelno
					 foundself = true
					 end
					 
				else
					 thislevel.levelno = lastlevel + 1
						print "!!!!!!!!!!!!!!!!!!!!!!!!??????????!"
						print thislevel.levelno
					 
				end
			lastlevel = level.levelno
			end	
			
			
		else self.levelno = 1
		end
		
		
	
	end
	
	def enforce_sequential_levels
		game_levels = Level.where("game_id = ?", game_id)
        game_levels.order('levelno ASC, xp_to_next_level ASC')
		#game_levels.order('xp_to_next_level ASC')
		howmanylevels = game_levels.count
		
		print howmanylevels
		print "MEGA COCK!!!!!!!"
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