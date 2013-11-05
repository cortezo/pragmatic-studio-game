class Die
	attr_reader :number

	def initialize(die_sides)
		@die_sides = die_sides
	end

	def roll
		@number = rand(1..@die_sides)
	end
end