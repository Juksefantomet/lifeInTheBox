require 'gosu'
require 'socket'

@server = TCPServer.new 18028

class Game < Gosu::Window
	attr_accessor :width, :heigth
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
		#Thread.start(@server.accept) do |client|
		client = @server.accept
		client.puts(Time.now.ctime + " Saying hello")
		client.close
	    #end		
	end
end

Game.new.show