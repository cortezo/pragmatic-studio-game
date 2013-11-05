require_relative 'player_class'
require_relative 'die_class'
require_relative 'game_turn'
require_relative 'treasure_trove'
require 'csv'

class Game
	attr_reader :title

	def initialize(title)
		@title = title
		@players = []
		@turn = 0
	end

	def add_player(player)
		@players << player
	end

	def load_players(filename)
		CSV.foreach(filename) do |row|
			add_player(Player.new(row[0], row[1].to_i))
		end

		##File.readlines(filename).each do |line|
		#	add_player(Player.from_csv(line))
		#end
	end

	def save_high_scores(filename="highscores.txt")
		File.open(filename, "w") do |file|
			file.puts "#{@title} High Scores:\n"
			sort_player_list.each do |player|
				file.puts "\n" + return_player_stats(player) + "\n"
			end
		end
		puts "\n\nHigh Scores output to file #{filename}."
	end

	def play(rounds)
	
		treasures = TreasureTrove::TREASURES
		puts "\nThere are #{treasures.size} treasures to be found:"
		treasures.each { |t| puts "A #{t.name} is worth #{t.points} points"}
		puts "\n\n"

		rounds.times do
			@turn += 1
			puts "\n*****The game is #{@title} and round #{@turn} commences now!*****"

			@players.each do |player| 
				GameTurn.take_turn(player)
				puts "\n"
			end
		end
	end

	def print_name_and_health(player)
		puts "#{player.name.ljust(15, '.')} #{player.health}"
	end
	
	def print_stats
		puts "\n\n" + "#{@title} Game Stats!".center(40, '*')

		sort_player_list.each do |player|
			puts "\n" + return_player_stats(player) + "\n"
		end

		puts "Total Treasure Points Accumulated:  #{total_points}"
	end

	def return_player_stats(player)
		player_stats = "#{player.name}".center(35, '-') + "\n" + "Treasure\n"
			
		player.each_found_treasure { |treasure| player_stats << "#{treasure.name.capitalize}:".ljust(25, '.') + "#{treasure.points}".rjust(10, '.') + "\n" }
		
		player_stats << "Treasure Score: #{player.points}".rjust(35, ' ') + "\n"
		player_stats << "Final Game Score:  #{player.score}".rjust(35, '-')
		player_stats
	end

	def sort_player_list
		@players.sort{ |a,b| a<=>b }
	end
	
	def total_points
		@players.reduce(0) { |sum, player| sum + player.points}
	end
end

if __FILE__ == $0
	jumanji = Game.new("Jumanji")
	player1 = Player.new("moe")
	player2 = Player.new("larry", 65)
	player3 = Player.new("curly", 150)
	jumanji.add_player(player1)
	jumanji.add_player(player2)
	jumanji.add_player(player3)
	jumanji.play(4)
end
