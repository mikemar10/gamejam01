class MenuScreen
  include Screen

  def initialize(game)
    @game = game
  end

  def show #create
    $logger.info 'MenuScreen#show'
  end

  def hide
    dispose
  end

  def render(delta)
    Gdx.gl.glClearColor(0, 0.7, 0, 1)
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)
  end

  def resize(w, h)
  end

  def pause
  end

  def resume
  end
end
