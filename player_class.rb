require_relative 'treasure_trove'

class Player
	attr_reader :health
	attr_accessor :name

	def initialize(name, health=100)
		@name = name.capitalize
		@health = health
		@found_treasure = Hash.new(0)
	end

	def name=(new_name)
		@name = new_name.capitalize
	end

	def <=> (other)
		other.score <=> score
	end
	
	def self.from_csv(string)
		name, health = string.split(',')
		Player.new(name, Integer(health))
	end

	def return_name
		@name
	end

	def to_s
		"I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}."
	end

	def blam
		@health -= 10
		puts "#{@name} got blammed in the right testicle!"
	end

	def w00t
		@health += 15
		puts "#{@name} got w00ted in the happy spot!"
	end

	def score
		@health + points
	end

	def strong?
		@health >= 100 ? true : false			
	end

	def found_treasure(treasure)
		@found_treasure[treasure.name] += treasure.points
		puts "#{@name} found a #{treasure.name} worth #{treasure.points} points!"
		puts "#{@name}'s treasures:  #{@found_treasure}"
	end

	def each_found_treasure
		@found_treasure.each do |name, points|
			yield Treasure.new(name, points)
		end
	end

	def points
		@found_treasure.values.reduce(0, :+)
	end
end

if __FILE__ == $0
	testplayer1 = Player.new("Monstreau", 1000)

	puts testplayer1

	testplayer1.blam
	testplayer1.w00t
	testplayer1.score

	testplayer2 = Player.new("Mufforeau", 950)

	puts testplayer1
	puts testplayer2

	testplayer2.attack(testplayer1)

	print ""
	puts testplayer1
	puts testplayer2
end