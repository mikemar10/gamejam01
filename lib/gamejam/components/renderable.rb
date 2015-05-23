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

  def marshal_dump
    [
      self.filename,
      self.rotation
    ]
  end

  def marshal_load(array)
    self.filename, self.rotation = array
    self.image = $textures[self.filename] ||= Texture.new(Gdx.files.internal(self.filename))
  end
end
