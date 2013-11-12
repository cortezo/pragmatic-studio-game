module Playable

	def blam
		self.health -= 10
		puts "#{self.name} got blammed in the right testicle!"
	end

	def w00t
		self.health += 15
		puts "#{self.name} got w00ted in the happy spot!"
	end

	def strong?
		self.health >= 100 ? true : false			
	end
end