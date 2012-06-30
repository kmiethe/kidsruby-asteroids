require 'gosu'

class Game < Gosu::Window
	def initialize
		super(900, 700, false)
		self.caption = "Game"
	end

	def update
	end

	def draw
	end
end

window = Game.new
window.show