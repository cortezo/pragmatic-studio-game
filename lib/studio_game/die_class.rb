require_relative 'auditable'

module StudioGame
	class Die
		include Auditable

		attr_reader :number

		def initialize(die_sides)
			@die_sides = die_sides
		end

		def roll
			@number = rand(1..@die_sides)
			audit
			@number
		end
	end
end