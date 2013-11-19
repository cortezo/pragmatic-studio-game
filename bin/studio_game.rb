require_relative '..\lib\studio_game\game_class'
require_relative '..\lib\studio_game\clumsyplayer_class'
require_relative '..\lib\studio_game\berserkplayer_class'

jumanji = StudioGame::Game.new("Jumanji")

default_player_file = File.join(File.dirname(__FILE__), 'players.csv')

jumanji.load_players(ARGV.shift || default_player_file)
jumanji.add_player(StudioGame::ClumsyPlayer.new("klutzy", 100, 3))
jumanji.add_player(StudioGame::BerserkPlayer.new("rampage", 110))

loop do
	puts "How many rounds would you like to play? ('quit' to exit)"
	answer = gets.chomp.downcase
	
	case answer
	when /^\d+$/
		puts "\n#{answer} rounds of game will now commence!\n\n\n"
		jumanji.play(answer.to_i)
	when 'quit', 'exit'
		jumanji.print_stats
		jumanji.save_high_scores()
		break
	else
		puts "Your input was stupid, Stupid.  Please enter an integer or 'quit' to exit the program."
	end	
end
