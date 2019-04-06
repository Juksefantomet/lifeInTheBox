$LOAD_PATH.unshift(File.expand_path('components', __dir__))

require 'gosu'
# require 'socket'

# Game components
require 'ammo'
require 'tank'

$shot_fired = false


# The class that runs the game - woop!
class Game < Gosu::Window
  attr_accessor :width, :height

  def initialize
    @width = 1024
    @height = 768
    super(width, height, false)
    self.caption = 'Life in the box - DEMO'
    vars_test
    images_test
    @boss = Tank.new(@width, @height, @image_boss)
    @player = Tank.new(@width, @height, @image_player)
    @tank_bullet = Ammo.new(@image_bullet)
  end

  def vars_test
    @base_speed = 3
    @xx = @yy = @x = @y = @h = @a = @check_tick = @temp_tick = 0
    @angle = 0.0
  end

  def images_test
    @image_bullet = Gosu::Image.new('bullet.png')
    @image_player = Gosu::Image.load_tiles('496x63_tank_4.png', 124, 63)
    @image_boss = Gosu::Image.new('boss.png')
    # @background_image = Gosu::Image.new("bg.png", :tileable => true)
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE then
      close
      puts 'Quitting'
    when Gosu::KB_RIGHT_SHIFT, Gosu::KB_LEFT_SHIFT then
      return if @run_boost_active
      puts 'Activating Run boost! (5 seconds)'
      @run_boost_active = true
      @player.accelerate
    end
  end

  def needs_cursor?
    false
  end

  # make this an independant class
  def drawgui()
  end

  def tickcooldowns
    if @temp_tick != 300
      @temp_tick += 1
    end
    return unless @temp_tick == 300
    @temp_tick == 300
    @temp_tick = 0
    @run_boost_active = false
    @run_cool_down_active = true
    @player.slowdown
  end

  def checkticks
    if @check_tick == 60
      @check_tick = 0
    else
      @check_tick += 1
    end
    $shot_fired? @tank_bullet_tick += 1 : @tank_bullet_tick = 0
    if @check_tick == 10
      @tank_bullet_tick = 0
      $shot_fired = false
    end
    return unless @run_boost_active
    tickcooldowns
  end

  def update
    checkticks
    # drawgui
    @boss.update
    @player.update
  end

  def draw
    @boss.draw(@x, @y, 1)
    @player.drawrot(@xx, @yy, @zz)
    if $shot_fired == true
      @tank_bullet.draw(@x, @y, 1)
    end
  end
end

Game.new.show
