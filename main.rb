require 'gosu'
require 'socket'

@s = TCPSocket.new('localhost', 18028)

class Game < Gosu::Window
	attr_accessor :width, :heigth
	def initialize
		@width = 1024
		@heigth = 768
		super(width, heigth, false)
		self.caption = "Life in the box - client"
	end
	def button_down(id)
		case id
		when Gosu::KbEscape then close
		when Gosu::KbK then
			line = @s.gets
			puts line
		#	close
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

Game.new.show