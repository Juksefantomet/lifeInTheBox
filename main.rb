require 'gosu'

class Game < Gosu::Window
	attr_accessor :width
	def initialize
		@width = 1024
		@heigth = 768
		super(width, heigth, false)
		self.caption = "Life in the box - client"
	end
	def button_down(id)
		case id
		when Gosu::KbEscape then close
		end
	end
	def needs_cursor?
		true
	end
	def update

	end
	def draw

	end
end


game = Game.new
game.show