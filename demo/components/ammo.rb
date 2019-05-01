# frozen_string_literal: true

# Ammo
class Ammo
  attr_accessor

  def initialize(image)
    @image = image
    if @image == nil
      print("image empty")
    end
    @bullet_speed = 30
    @damage = 10
    @bullet_angle = 0
  end

  def drawrot(*)
    @image.draw_rot(@ax, @ay, @az, @angle, 0.1, 0.1, 0.1, 0.1)
  end

  def set_bullet_loc(x, y, z, facing)
    @ax = x
    @ay = y
    @az = z
    @facing = facing
  end

  def fire(direction)
    case direction
    when 'left'
      @bullet_angle = 90
      @ax -= @bullet_speed
    when 'right'
      @bullet_angle = -90
      @ax += @bullet_speed
    when 'up'
      @bullet_angle = 180
      @ay -= @bullet_speed
    when 'down'
      @bullet_angle = 0
      @ay += @bullet_speed
    end
  end

  def update
    if $shot_fired
      # @image.draw(@ax, @ay, @az)
      @image.draw_rot(@ax, @ay, @az, @bullet_angle, 0.5, 0.5, 0.8)
    end
  end
end