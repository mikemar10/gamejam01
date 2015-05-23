require 'systems/system'
require 'components/renderable'
require 'components/position'

class RenderingSystem < System
  def process(entity_manager, batch)
    batch.begin
    entity_manager.renderable_components.each do |id, render_comp|
      position_comp = entity_manager.position_components[id]
      batch.draw(render_comp.image, position_comp.x, position_comp.y)
    end
    batch.end
  end
end
