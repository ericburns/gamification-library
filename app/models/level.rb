class Level < ActiveRecord::Base
	# -------------- Accessors/Mutators
	attr_accessible :xp_to_next_level, :game_id, :levelno
	#default_scope order('levelno ASC, xp_to_next_level ASC')
	default_scope order('xp_to_next_level ASC')

	# -------------- Associations
	belongs_to :game

	# -------------- Callbacks
	after_save :levelsync
	
	# -------------- Validations
	validates :xp_to_next_level, :presence => true
	validates :xp_to_next_level, :numericality => {:greater_than => 0}
	validates :game_id, :existence => true
	validates :levelno, :numericality => {:greater_than => 0}
	#validates_uniqueness_of :levelno, :scope => [:game_id]  -- Not needed anymore?? 

	# -------------- Custom Validation Methods

	def levelsync
		game_levels = Level.where("game_id = ?", game_id)
		game_levels.order('xp_to_next_level ASC')
		@prev = 0
		thismanylevels = game_levels.count
			if (game_levels.count > 0)
				game_levels.each do |level|

					@prev += 1
					Level.where("id = ?", level.id).update_all(:levelno => @prev)
					
		
				end
			
			end	
	end
	
	
	
end
