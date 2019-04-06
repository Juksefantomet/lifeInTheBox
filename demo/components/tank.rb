# frozen_string_literal: true

# tank
class Tank
  attr_accessor

  def initialize(width, height, image, ammo_image)
    @image = image
    @xx = 0
    @yy = 0
    @zz = 0
    @h = 0
    @a = 0
    @angle = 0.0
    @width = width
    @height = height
    @x = 0
    @y = 0
    @z = 0
    @base_speed = 3
    @tank_bullet = Ammo.new(ammo_image)
  end

  def draw(*)
    @image.draw(@x, @y, @z)
  end

  def drawrot(*)
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
    spin_tank_wheels
    @xx += -@base_speed
    @angle = -180.0
  end

  def moveright
    spin_tank_wheels
    @xx += @base_speed
    @angle = 0.0
  end

  def moveup
    spin_tank_wheels
    @yy += -@base_speed
    @angle = -90.0
  end

  def movedown
    spin_tank_wheels
    @yy += @base_speed
    @angle = 90.0
  end

  def moveupright
    spin_tank_wheels
    @xx += @base_speed / 8
    @yy += -@base_speed / 8
    @angle = -45.0
  end

  def moveupleft
    spin_tank_wheels
    @xx += -@base_speed / 8
    @yy += -@base_speed / 8
    @angle = -135.0
  end

  def movedownright
    spin_tank_wheels
    @yy += @base_speed / 8
    @xx += @base_speed / 8
    @angle = 45.0
  end

  def movedownleft
    spin_tank_wheels
    @yy += @base_speed / 8
    @xx += -@base_speed / 8
    @angle = 135.0
  end

  def accelerate
    @base_speed = 10
  end

  def slowdown
    @base_speed = 3
  end

  def fire_bullet
    # @tank_bullet.draw
    if $shot_fired
      puts "Fired da gun: #{$shot_fired}"
    end
    # @tank_bullet = Ammo.new(@image_bullet)
    # @tank_bullet.bullet(@x, @y, @z)
    # @tank_bullet.draw(@x, @y, @z)
    # Create bullet at xx,yy loc
    # give travel time pr. tick set by bullet variable.
    # calculate angle where to shoot from player angle
  end

  def update
    center_the_boss
  end
end