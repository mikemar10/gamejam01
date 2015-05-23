require 'constants'
require 'components/player_input'
require 'components/position'
require 'systems/system'

class InputSystem < System
  def process(entity_manager, delta)
    entity_manager.playerinput_components.each do |id, input_comp|
      position_comp = entity_manager.position_components[id]
      if Gdx.input.isKeyPressed(P1_KEY_UP) && input_comp.keys.include?(P1_KEY_UP)
        position_comp.y += 500 * delta
      end

      if Gdx.input.isKeyPressed(P1_KEY_DOWN) && input_comp.keys.include?(P1_KEY_DOWN)
        position_comp.y -= 500 * delta
      end

      if Gdx.input.isKeyPressed(P1_KEY_LEFT) && input_comp.keys.include?(P1_KEY_LEFT)
        position_comp.x -= 500 * delta
      end

      if Gdx.input.isKeyPressed(P1_KEY_RIGHT) && input_comp.keys.include?(P1_KEY_RIGHT)
        position_comp.x += 500 * delta
      end

      if Gdx.input.isKeyJustPressed(P1_KEY_TIME_TRAVEL) && input_comp.keys.include?(P1_KEY_TIME_TRAVEL)
        @game.travel_back_twenty_seconds
      end
    end
  end
end
