require_relative 'treasure_trove'

module GameTurn
	def self.take_turn(player)
			die = Die.new(6)

			number_rolled = die.roll

			if number_rolled >= 5
				player.w00t
			elsif number_rolled > 2 && number_rolled <= 4
				puts "#{player.name} was skipped."
			else
				player.blam
			end

			treasure = TreasureTrove.random
			player.found_treasure(treasure)
	end
end
