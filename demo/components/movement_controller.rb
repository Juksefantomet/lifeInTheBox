# frozen_string_literal: true

class MovementController
  def movement_controller(obj)
    if Gosu.button_down? Gosu::KB_LEFT
      obj.moveleft
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      obj.moveright
    end
    if Gosu.button_down? Gosu::KB_UP
      obj.moveup
    end
    if Gosu.button_down? Gosu::KB_DOWN
      obj.movedown
    end
    if (Gosu.button_down? Gosu::KB_UP and Gosu.button_down? Gosu::KB_RIGHT) or (Gosu.button_down? Gosu::KB_RIGHT and Gosu.button_down? Gosu::KB_UP)
      obj.moveupright
    end
    if (Gosu.button_down? Gosu::KB_DOWN and Gosu.button_down? Gosu::KB_RIGHT) or (Gosu.button_down? Gosu::KB_RIGHT and Gosu.button_down? Gosu::KB_DOWN)
      obj.movedownright
    end
    if (Gosu.button_down? Gosu::KB_UP and Gosu.button_down? Gosu::KB_LEFT) or (Gosu.button_down? Gosu::KB_LEFT and Gosu.button_down? Gosu::KB_UP)
      obj.moveupleft
    end
    if (Gosu.button_down? Gosu::KB_DOWN and Gosu.button_down? Gosu::KB_LEFT) or (Gosu.button_down? Gosu::KB_LEFT and Gosu.button_down? Gosu::KB_DOWN)
      obj.movedownleft
    end
    if Gosu.button_down? Gosu::KB_SPACE
      # @tank_bullet.x = @xx
      # @tank_bullet.y = @yy
      # @tank_bullet.z = @zz
      obj.fire_bullet
    end
  end
end