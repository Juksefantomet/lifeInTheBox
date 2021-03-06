# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('components', __dir__))

require 'gosu'
# require 'socket'

# Game components
require 'ammo'
require 'tank'
require 'gui'

# player controller
require 'movement_controller'

$shot_fired = false
$fire_cooldown = false


# The class that runs the game - woop!
class Game < Gosu::Window
  attr_accessor :width, :height

  def initialize
    @firecooldown = 0
    @controller = MovementController.new
    @width = 1024
    @height = 768
    super(width, height, false)
    self.caption = 'Life in the box - DEMO'
    vars_test
    images_test
    @boss = Tank.new(@width, @height, @image_boss, @image_bullet)
    @player = Tank.new(@width, @height, @image_player, @image_bullet)
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

  def tick_cooldowns
    if @temp_tick != 300
      @temp_tick += 1
    end
    return unless @temp_tick == 300
    if @temp_tick == 300
      @temp_tick = 0
      @run_boost_active = false
      @run_cool_down_active = true
      @player.slowdown
    end
  end

  def check_ticks
    if @check_tick == 60
      @check_tick = 0
    else
      @check_tick += 1
    end

    if $shot_fired
      @firecooldown += 1
      if @firecooldown >= 60
        $shot_fired = false
        $fire_cooldown = false
        @firecooldown = 0
      end
    else
      # do nothing
    end


    return unless @run_boost_active

    tick_cooldowns
  end

  def update
    check_ticks
    @boss.update
    @player.update
    @controller.movement_controller(@player)
  end

  def draw
    @boss.draw(@x, @y, 1)
    @player.drawrot(@xx, @yy, @zz)
    unless $fire_cooldown && $shot_fired
      @player.fire_bullet
    end
  end
end

Game.new.show
