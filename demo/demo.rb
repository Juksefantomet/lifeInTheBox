require 'gosu'
# require 'socket'

# movement controller
class Player_movement
  attr_accessor
  def initialize
    @xx = 0
    @yy = 0
    @angle = 0
    @base_speed = 3
    @button_down = Gosu::KB_LEFT
  end

  def moveleft
    # return unless button_down? Gosu::KB_LEFT
    # spin_tank_wheels
    @xx += -@base_speed
    @angle = -180.0
  end

  def moveright
    # return unless button_down? Gosu::KB_RIGHT
    # spin_tank_wheels
    @xx += @base_speed
    @angle = 0.0
  end

  def moveup
    # return unless button_down? Gosu::KB_UP
    # spin_tank_wheels
    @yy += -@base_speed
    @angle = -90.0
  end

  def movedown
    # return unless button_down? Gosu::KB_DOWN
    # spin_tank_wheels
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

  def update
    movement_controller
  end
end

# tank class - type player/boss - image used
class Tank
  attr_accessor
  def initialize(width, heigth)
    @image_player = Gosu::Image.load_tiles('496x63_tank_4.png', 124, 63)
    @image_boss = Gosu::Image.new('boss.png')
    @xx = @yy = @zz = @h = @angle = @a = @b = @c = 0
    @width = width
    @heigth = heigth
    @x = @width / 2
    @y = @heigth / 2
    @z = 0
  end

  def accelerate()end

  def draw_player(h, xx, yy, zz, angle, a, b, c)
    # @image_player[@h].draw_rot(@xx, @yy, 0, @angle, 0.5, 0.5, 0.8)
    @image_player[@h].draw_rot(@xx, @yy, @zz, @angle, @a, @b, @c)
  end

  def draw_boss(x, y, z)
    @image_boss.draw(@x, @y, @z)
  end

  def center_the_boss
    @x = @width / 2 + Math.cos(Time.now.to_f) * 150
    @y = @heigth / 2 + Math.sin(Time.now.to_f) * 150
  end

  def update
    center_the_boss
  end
end

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
    @boss = Tank.new(@width, @heigth)
    @player = Tank.new(@width, @heigth)
    movement = Player_movement.new
  end

  def vars_test
    @base_speed = 3
    @xx = @yy = @x = @y = @h = @a = @check_tick = @temp_tick = 0
    @angle = 0.0
  end

  def images_test
    @image_bullet = Gosu::Image.new('bullet.png')
    
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

  # Function draw calls this when moving to do wheel animations
  def spin_tank_wheels
    @h = @a
    @a = (@a + 1).modulo(4)
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
    movement.update
    # movement_controller
    checkticks
    # drawgui
    @boss.update
  end

  def draw
    @boss.draw_boss(@x, @y, 1)
    @player.draw_player(@h, @xx, @yy, 0, @angle, 0.5, 0.5, 0.8)
    # @image_boss.draw(@x, @y, 1)
    # @image_player[@h].draw_rot(@xx, @yy, 0, @angle, 0.5, 0.5, 0.8)
  end
end

Game.new.show
