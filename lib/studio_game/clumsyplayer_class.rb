require_relative 'player_class'

module StudioGame
	class ClumsyPlayer < Player
		attr_reader :boost_factor

		def initialize(name, health=100, boost=1)
			super(name, health)
			@boost_factor = boost
		end

		def found_treasure(treasure)
			super(Treasure.new(treasure.name, treasure.points/2.0))
		end

		def w00t
			@boost_factor.times { super }
		end
	end
end

if __FILE__ == $0
	clumsy = StudioGame::ClumsyPlayer.new("klutz")

	hammer = StudioGame::Treasure.new(:hammer, 50)
	clumsy.found_treasure(hammer)
	clumsy.found_treasure(hammer)
	clumsy.found_treasure(hammer)

	crowbar = StudioGame::Treasure.new(:crowbar, 400)
	clumsy.found_treasure(crowbar)

	clumsy.each_found_treasure do |treasure|
		puts "#{treasure.points} total #{treasure.name} points"
	end
	puts "#{clumsy.points} grand total points"
end