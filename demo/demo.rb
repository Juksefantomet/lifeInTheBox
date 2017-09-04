require 'gosu'
# require 'socket'

# The class that runs the game - woop!
class Game < Gosu::Window
  attr_accessor :width, :heigth
  def initialize
    @width = 1024
    @heigth = 768
    super(width, heigth, false)
    self.caption = 'Life in the box - DEMO'
    vars_test
    images_test

  end
  
  def vars_test
    @base_speed = 3
    @run_boost_active = false
    @run_cool_down_active = false
    @xx = @yy = @x = @y = @h = @a = @check_tick = @temp_tick = 0
    @angle = 0.0 
  end

  def images_test
    @image_boss = Gosu::Image.new('boss.png')
    @image_bullet = Gosu::Image.new('bullet.png')
    @image_player = Gosu::Image.load_tiles('496x63_tank_4.png', 124, 63)
    # @background_image = Gosu::Image.new("bg.png", :tileable => true)
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE then
      close
      puts 'Quitting'
    when Gosu::KB_RIGHT_SHIFT then
      return if @run_boost_active
      puts 'Activating Run boost! (5 seconds)'
      @run_boost_active = true
      @base_speed = 10
    end
  end

  def spin_tank_wheels
    if @a == 3
      @h = @a
      @a = 0
    else
      @a += 1
      @h = @a
    end
  end

  def fire_bullet
    return unless button_down? Gosu::KB_SPACE
    # Create bullet at xx,yy loc
    # give travel time pr. tick set by bullet variable.
    # calculate angle where to shoot from player angle
  end

  def moveleft
    return unless button_down? Gosu::KB_LEFT
    spin_tank_wheels
    @xx += -@base_speed
    @angle = -180.0
  end

  def moveright
    return unless button_down? Gosu::KB_RIGHT
    spin_tank_wheels
    @xx += @base_speed
    @angle = 0.0
  end

  def moveup
    return unless button_down? Gosu::KB_UP
    spin_tank_wheels
    @yy += -@base_speed
    @angle = -90.0
  end

  def movedown
    return unless button_down? Gosu::KB_DOWN
    spin_tank_wheels
    @yy += @base_speed
    @angle = 90.0
  end

  def accelerate()end

  def slowdown()end

  def movement_controller
    if Gosu::KB_LEFT
      moveleft
    end
    if Gosu::KB_RIGHT
      moveright
    end
    if Gosu::KB_UP
      moveup
    end
    if Gosu::KB_DOWN
      movedown
    end
  end

  def needs_cursor?
    false
  end

  def drawgui()end

  def tickcooldowns
    if @temp_tick != 300
      @temp_tick += 1
    end
    return unless @temp_tick == 300
    @temp_tick == 300
    @temp_tick = 0
    @run_boost_active = false
    @run_cool_down_active = true
    @base_speed = 5
  end

  def checkticks
    if @check_tick == 60
      @check_tick = 0
    else
      @check_tick += 1
    end
    return unless @run_boost_active
      tickcooldowns
  end

  def update
    movement_controller
    checkticks
    # drawgui
    @x = @width / 2 + Math.cos(Time.now.to_f) * 75
    @y = @heigth / 2 + Math.sin(Time.now.to_f) * 75
  end

  def draw
    @image_boss.draw(@x, @y, 1)
    @image_player[@h].draw_rot(@xx, @yy, 0, @angle, 0.5, 0.5, 0.8)
  end
end

Game.new.show
