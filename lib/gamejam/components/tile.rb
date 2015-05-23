require 'components/component'

Tile = Component.new(:x, :y, :texture) do
  extend Forwardable
  def_delegators :texture, :width, :height

  def initialize(*)
    super
    $textures[self.id] = self.texture
  end

  def marshal_dump
    [
      self.id,
      self.x,
      self.y
    ]
  end

  def marshal_load(array)
    self.id, self.x, self.y = array
    self.texture = $textures[self.id]
  end
end
