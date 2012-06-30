require 'gosu'

class FirstGame < Gosu::Window
	def initialize
		super(600, 400, false)
		@player1 = Player.new(self)
		@balls = 4.times.map {Ball.new(self)}
		@running = true
	end

	def update
		if @running
			@player1.move_left if button_down? Gosu::Button::KbLeft
			@player1.move_right if button_down? Gosu::Button::KbRight
			@player1.move_up if button_down? Gosu::Button::KbUp
			@player1.move_down if button_down? Gosu::Button::KbDown

			@balls.each {|ball| ball.update}

			if @player1.hit_by? @balls
				stop_game!
			end
		else
			#the game is currently stopped
			restart_game if button_down? Gosu::Button::KbEscape
		end
	end

	def draw
		@player1.draw
		@balls.each {|ball| ball.draw}
	end

	def stop_game!
		@running = false
	end

	def restart_game
		@running = true
		@balls.each {|ball| ball.reset!}
	end

end


class Player
	def initialize (game_window)
		@game_window = game_window
		@icon = Gosu::Image.new(@game_window, "player1.png", true)
		@x = 150
		@y = 330
	end

	def draw
		@icon.draw(@x, @y, 1)
	end

	def move_left
		@x = [@x - 10, 0].max
	end

	def move_right
		@x = [@x + 10, @game_window.width - 90].min
	end

	def move_up
		@y = [@y - 10, 0].max
	end

	def move_down
		@y = [@y + 10, @game_window.height - 90].min
	end

	def hit_by?(balls)
		balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 50}
	end
end


class Ball
	def initialize(game_window)
		@game_window = game_window
		@icon = Gosu::Image.new(@game_window, "asteroid.png", true)
		reset!
	end

	def update
		@y = (@y > @game_window.height)? reset! : @y + 7
	end

	def draw
		@icon.draw(@x, @y, 2)
	end

	def x
		@x
	end

	def y
		@y
	end

	def reset!
		@x = rand(@game_window.width)
		@y = -50
	end

end

window = FirstGame.new
window.show