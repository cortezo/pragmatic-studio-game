require_relative 'player_class'
require_relative 'treasure_trove'

describe Player do

	before do
		$stdout = StringIO.new  ##suppresses all print output.
	end

	context "basic functionality testing" do

		before do
			@initial_health = 200
			@player = Player.new("buffaro", @initial_health)
		end

		it "has capitalized name" do
			@player.name.should == "Buffaro"
		end

		it "has correct health" do
			@player.health.should == @initial_health
		end

		it "has a string representation" do
			@player.to_s.should == "I'm Buffaro with health = #{@initial_health}, points = #{@player.points}, and score = #{@player.score}."
		end

		it "reduces player health by 10 when blammed" do
			@player.blam

			@player.health.should == @initial_health - 10
		end

		it "increases player health by 15 when w00ted" do
			@player.w00t

			@player.health.should == @initial_health + 15
		end

		it "adds found treasures and health to create a score" do
			@player.found_treasure(Treasure.new(:hammer, 50))
			@player.found_treasure(Treasure.new(:hammer, 50))

			@player.score.should == 300
		end

		it "computes a score as the sum of its health and points" do
			@player.score.should == @initial_health + @player.points
		end

		it "computes points as the sum of all treasure points" do
			@player.points.should == 0

			@player.found_treasure(Treasure.new(:hammer, 50))

			@player.points.should == 50

			@player.found_treasure(Treasure.new(:crowbar, 400))
			  
			@player.points.should == 450
			  
			@player.found_treasure(Treasure.new(:hammer, 50))

			@player.points.should == 500
		end
		
		it "yields each found treasure and its total points" do
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:hammer, 50))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  
		  yielded = []
		  @player.each_found_treasure do |treasure|
		    yielded << treasure
		  end
		  
		  yielded.should == [
		    Treasure.new(:skillet, 200), 
		    Treasure.new(:hammer, 50), 
		    Treasure.new(:bottle, 25)
		 ]
		end

		it "can be created from a CSV string" do  
			player = Player.from_csv("larry,150")
			
			player.name.should == "Larry"
			player.health.should == 150
		end
	end

	context "a player with a health greater than 100" do
		before do
			@initial_health = 150
			@player = Player.new("UltraMan", @initial_health)
		end

		it "says that our player is strong if their health is greater/equal to than 100" do
			@player.should be_strong  ##this is equivalent to @player.strong?.should == true
		end
	end

	context "a player with health less than 100" do
		before do
			@initial_health = 90
			@player = Player.new("MediocreMan", @initial_health)
		end

		it "says that our player is wimpy if their health is less than 100" do
			@player.strong?.should == false
		end
	end
	
	context "in a collection of players" do
		before do
			@player1 = Player.new("moe", 100)
			@player2 = Player.new("larry", 200)
			@player3 = Player.new("curly", 300)
			
			@players = [@player1, @player2, @player3]
		end
		
		it "is sorted by decreasing score" do
			@players.sort.should == [@player3, @player2, @player1]
		end
	end
end