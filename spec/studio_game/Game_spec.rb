require 'studio_game\game_class'

module StudioGame
	describe Game do
		
		before do
			$stdout = StringIO.new  ##suppresses all print output.
		end

		before do
			@game = Game.new("Jumanji")
			
			@initial_health = 100
			@player = Player.new("moe", @initial_health)

			@game.add_player(@player)
			
			@turns = 2
		end

		it "assigns a treasure for points during a player's turn" do     
			@game.play(1)
			  
			@player.points.should_not be_zero
		end

		it "computes total points as the sum of all player points" do
			game = Game.new("Knuckleheads")
			  
			player1 = Player.new("moe")
			player2 = Player.new("larry")

			game.add_player(player1)
			game.add_player(player2)
			  
			player1.found_treasure(Treasure.new(:hammer, 50))
			player1.found_treasure(Treasure.new(:hammer, 50))
			player2.found_treasure(Treasure.new(:crowbar, 400))
			  
			game.total_points.should == 500
		end

		context "Die rolls a high number" do
			before do
				Die.any_instance.stub(:roll).and_return(5)
			end

			it "should w00t our player when a high number is rolled" do
				@game.play(@turns)

				@player.health.should == @initial_health + (15 * @turns)
			end
		end

		context "Die rolls a medium number" do
			before do
				Die.any_instance.stub(:roll).and_return(3)
			end

			it "should not change player health when 3 or 4 is rolled" do
				@game.play(@turns)

				@player.health.should == @initial_health
			end
		end

		context "Die rolls a low number" do
			before do
				Die.any_instance.stub(:roll).and_return(1)
			end

			it "should blam a player when a low number is rolled" do
				@game.play(@turns)

				@player.health.should == @initial_health - (10 * @turns)
			end
		end
	end
end