# frozen_string_literal: true

# Ammo
class Ammo
  attr_accessor

  def initialize(image)
    @image = image
    if @image == nil
      print("image empty")
    end
    @bullet_speed = 10
    @damage = 10
    @x = 0
    @y = 0
    @z = 0
  end

  def draw(*)
    @image.draw(1, 1, 1)
    # Create bullet at xx,yy loc
    # give travel time pr. tick set by bullet variable.
    # calculate angle where to shoot from player angle
  end

  def update(*)
    @x = @x + @bullet_speed
    # @image.draw(@x, @y, @z)
  end
end