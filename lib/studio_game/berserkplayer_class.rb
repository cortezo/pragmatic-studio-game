require_relative 'player_class'

module StudioGame
	class BerserkPlayer < Player

		def initialize(name, health=100)
			super
			@w00t_count = 0
		end

		def berserk?
			if @w00t_count > 5
				true
			else
				false
			end
		end

		def w00t
			super
			@w00t_count += 1

			puts "***#{@name} is berserk!!***" if berserk?
		end

		def blam
			if berserk?
				w00t
			else
				super
			end
			##equivalent:
			#berserk? ? w00t : super
		end



	end
end

if __FILE__ == $0
  berserker = StudioGame::BerserkPlayer.new("berserker", 50)
  6.times { berserker.w00t }
  2.times { berserker.blam }
end