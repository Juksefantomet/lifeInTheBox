require 'gosu'
# require 'socket'

# tank class - type player/boss - image used
class Tank
  attr_accessor
  def initialize(width, height, image)
    @image = image
    @xx = 0
    @yy = 0
    @zz = 0
    @h = 0
    @angle = 0.0
    @a = 0
    @b = 0
    @c = 0
    @width = width
    @height = height
    @x = @width / 2
    @y = @height / 2
    @z = 0
    @base_speed = 3
  end

  def draw(x, y, z)
    @image.draw(@x, @y, @z)
  end
  def draw_rot(x, y, z, angle)
    @image[@h].draw_rot(@xx, @yy, @zz, @angle, 0.5, 0.5, 0.8)
  end
  def center_the_boss
    @x = @width / 2 + Math.cos(Time.now.to_f) * 150
    @y = @height / 2 + Math.sin(Time.now.to_f) * 150
  end

  # Function draw calls this when moving to do wheel animations
  def spin_tank_wheels
    @h = @a
    @a = (@a + 1).modulo(4)
  end

  def moveleft
    return unless Gosu.button_down? Gosu::KB_LEFT
    spin_tank_wheels
    @xx += -@base_speed
    @angle = -180.0
  end

  def moveright
    return unless Gosu.button_down? Gosu::KB_RIGHT
    spin_tank_wheels
    @xx += @base_speed
    @angle = 0.0
  end

  def moveup
    return unless Gosu.button_down? Gosu::KB_UP
    spin_tank_wheels
    @yy += -@base_speed
    @angle = -90.0
  end

  def movedown
    return unless Gosu.button_down? Gosu::KB_DOWN
    spin_tank_wheels
    @yy += @base_speed
    @angle = 90.0
  end

  def movement_controller
    if Gosu.button_down? Gosu::KB_LEFT
      moveleft
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      moveright
    end
    if Gosu.button_down? Gosu::KB_UP
      moveup
    end
    if Gosu.button_down? Gosu::KB_DOWN
      movedown
    end
  end

  def accelerate
    @base_speed = 10
  end

  def slowdown
    @base_speed = 3
  end

  def update
    center_the_boss
    movement_controller
  end
end

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
    when Gosu::KB_RIGHT_SHIFT then
      return if @run_boost_active
      puts 'Activating Run boost! (5 seconds)'
      @run_boost_active = true
      @player.accelerate
    end
  end

  def fire_bullet
    return unless button_down? Gosu::KB_SPACE
    # Create bullet at xx,yy loc
    # give travel time pr. tick set by bullet variable.
    # calculate angle where to shoot from player angle
  end

  def needs_cursor?
    false
  end

  # make this an independant class
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
    @player.slowdown
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
    checkticks
    # drawgui
    @boss.update
    @player.update
  end

  def draw
    @boss.draw(@x, @y, 1)
    @player.draw_rot(@xx, @yy, @zz, @angle)
    # @image_player[@h].draw_rot(@xx, @yy, @zz, @angle, 0.5, 0.5, 0.8)
    # @image_boss.draw(@x, @y, 1)
    # @image_player[@h].draw_rot(@xx, @yy, 0, @angle, 0.5, 0.5, 0.8)
  end
end

Game.new.show
