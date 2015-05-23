require 'systems/system'

class TileSystem < System
  def process(entity_manager, batch)
    entity_manager.tile_components.each do |id, tile_comp|
      batch.begin
      batch.draw(tile_comp.texture, tile_comp.x, tile_comp.y)
      batch.end
    end
  end
end
