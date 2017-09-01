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
		@base_speed = 5
		@checkTick = 0
		@tempTick = 0
		@runBoostActive = false
		@runCoolDownActive = false
	end
	def button_down id
		case id
		when Gosu::KbEscape then 
			close
			puts "Quitting"
		
		when Gosu::KbLeft then
			puts "moved left"
			@xx += -@base_speed
		
		when Gosu::KbRight then
			puts "moved right"
			@xx += @base_speed
		
		when Gosu::KbUp then
			puts "moved up"
			@yy += -@base_speed
		
		when Gosu::KbDown then
			puts "moved down"
			@yy += @base_speed
		when Gosu::KbRightShift then
			if @runBoostActive == false then
				puts "Activating Run boost! (5 seconds)"
				@runBoostActive = true
				@base_speed = 10
			end

		end
	end

	def needs_cursor?
		false
	end

	def update
		@x = @width/2 - @image_boss.width/2 + Math.cos(Time.now.to_f)*150
		@y = @heigth/2 + Math.sin(Time.now.to_f)*150
		@xx += -@base_speed if button_down? Gosu::KbLeft
		@xx += @base_speed if button_down? Gosu::KbRight
		@yy += -@base_speed if button_down? Gosu::KbUp
		@yy += @base_speed if button_down? Gosu::KbDown
		
		if @checkTick == 60 then @checkTick = 0 end
		if @checkTick != 60 then @checkTick += 1 end
		if @runBoostActive == true then
			if @tempTick != 300 then @tempTick += 1 end
			if @tempTick == 300 then 
				@tempTick = 0 
				@runBoostActive = false 
				@runCoolDownActive = true
				@base_speed = 5
			end
		end
		#puts @checkTick
	end

	def draw
		@image_boss.draw @x, @y, 0
		@image_player.draw @xx, @yy, 0
	end
end

Game.new.show