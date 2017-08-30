require 'gosu'

class Game < Gosu::Window
	attr_accessor :width
	def initialize
		@width = 1024
		@heigth = 768
		super(width, heigth, false)
		self.caption = "Server - Life in the box"
	end
	def button_down(id)
		case id
		when Gosu::KbEscape then close
		end
	end
	def needs_cursor?
		false
	end
	def update

	end
	def draw

	end
end


game = Game.new
game.show