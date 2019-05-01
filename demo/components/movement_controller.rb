# frozen_string_literal: true

# The movement controller class
class MovementController
  def movement_controller(obj)
    if Gosu.button_down? Gosu::KB_LEFT
      obj.moveleft
      obj.facing_direction('left')
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      obj.moveright
      obj.facing_direction('right')
    end
    if Gosu.button_down? Gosu::KB_UP
      obj.moveup
      obj.facing_direction('up')
    end
    if Gosu.button_down? Gosu::KB_DOWN
      obj.movedown
      obj.facing_direction('down')
    end
    if (Gosu.button_down? Gosu::KB_UP and Gosu.button_down? Gosu::KB_RIGHT) or (Gosu.button_down? Gosu::KB_RIGHT and Gosu.button_down? Gosu::KB_UP)
      obj.moveupright
      obj.facing_direction('up_right')
    end
    if (Gosu.button_down? Gosu::KB_DOWN and Gosu.button_down? Gosu::KB_RIGHT) or (Gosu.button_down? Gosu::KB_RIGHT and Gosu.button_down? Gosu::KB_DOWN)
      obj.movedownright
      obj.facing_direction('down_right')
    end
    if (Gosu.button_down? Gosu::KB_UP and Gosu.button_down? Gosu::KB_LEFT) or (Gosu.button_down? Gosu::KB_LEFT and Gosu.button_down? Gosu::KB_UP)
      obj.moveupleft
      obj.facing_direction('up_left')
    end
    if (Gosu.button_down? Gosu::KB_DOWN and Gosu.button_down? Gosu::KB_LEFT) or (Gosu.button_down? Gosu::KB_LEFT and Gosu.button_down? Gosu::KB_DOWN)
      obj.movedownleft
      obj.facing_direction('down_right')
    end

    if Gosu.button_down? Gosu::KB_SPACE
      unless $fire_cooldown
        $shot_fired = true
      end
    end
  end
end
