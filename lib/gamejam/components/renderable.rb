require 'components/component'
require 'forwardable'

Renderable = Component.new(:filename, :rotation, :image) do
  extend Forwardable
  def_delegators :image, :width, :height

  def initialize(*)
    super
    $textures ||= Hash.new
    self.image = $textures[self.filename] ||= Texture.new(Gdx.files.internal(self.filename))
    self.rotation ||= 0
  end

  def rotate(amount)
    self.rotation += amount
  end
end
