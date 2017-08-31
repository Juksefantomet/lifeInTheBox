require 'gosu'
require 'socket'

class Game < Gosu::Window
	attr_accessor :width, :heigth
	def initialize
		@width = 1024
		@heigth = 768
		super(width, heigth, false)
		self.caption = "Life in the box - DEMO"
	end
	def button_down(id)
		case id
		when Gosu::KbEscape then close
			puts "Quitting"
		
		when Gosu::KbLeft then
			puts "moved left"
		
		when Gosu::KbRight then
			puts "moved right"
		
		when Gosu::KbUp then
			puts "moved up"
		
		when Gosu::KbDown then
			puts "moved down"
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

Game.new.show