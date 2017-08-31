require 'gosu'
require 'socket'

class Game < Gosu::Window
	attr_accessor :width, :heigth
	def initialize
		@width = 1024
		@heigth = 768
		super(width, heigth, false)
		self.caption = "Life in the box - DEMO"
		@image_boss = Gosu::Image.from_text self, '\ooo/', Gosu.default_font_name, 100
		@image_player = Gosu::Image.from_text self, "X", Gosu.default_font_name, 100
		@xx = 0 #Math.cos(Time.now.to_f)*10
		@yy = 0 #Math.sin(Time.now.to_f)*10
	end
	def button_down id
		case id
		when Gosu::KbEscape then 
			close
			puts "Quitting"
		
		when Gosu::KbLeft then
			puts "moved left"
			@xx += -5
		
		when Gosu::KbRight then
			puts "moved right"
			@xx += 5
		
		when Gosu::KbUp then
			puts "moved up"
			@yy += -5
		
		when Gosu::KbDown then
			puts "moved down"
			@yy += 5
		end
	end

	def needs_cursor?
		false
	end

	def update
		@x = @width/2 - @image_boss.width/2 + Math.cos(Time.now.to_f)*150
		@y = @heigth/2 + Math.sin(Time.now.to_f)*150
		@xx += -5 if button_down? Gosu::KbLeft
		@xx += 5 if button_down? Gosu::KbRight
		@yy += -5 if button_down? Gosu::KbUp
		@yy += 5 if button_down? Gosu::KbDown
	end

	def draw
		@image_boss.draw @x, @y, 0
		@image_player.draw @xx, @yy, 0
	end
end

Game.new.show