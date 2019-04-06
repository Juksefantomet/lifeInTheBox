# Ammotypes
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
    @image.draw(@x, @y, @z)
    # Create bullet at xx,yy loc
    # give travel time pr. tick set by bullet variable.
    # calculate angle where to shoot from player angle
  end

  def update(*)
    # @image.draw(@x, @y, @z)
  end
end