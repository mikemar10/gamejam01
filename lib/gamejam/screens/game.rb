require 'components/component'
require 'components/gravity'
require 'components/input'
require 'components/position'
require 'components/renderable'
require 'entity_manager'
require 'systems/rendering_system'

class GameScreen
  include Screen

  def initialize(game)
    $debug = true
    @game = game
    @entity_manager = EntityManager.new
    @rendering_system = RenderingSystem.new(@game)
    @camera = OrthographicCamera.new
    @camera.setToOrtho(false, $screen_width, $screen_height)
    @batch = SpriteBatch.new
    @entity_manager.create_entity({
      tags: ['player'],
      components: [
        Position.new(rand(1280), rand(720)),
        Renderable.new("assets/libgdx.png")
      ]})
  end

  def show
    # This import can only be done here since we are already within the main
    # gdx thread which contains our opengl context.  Attempting to import this
    # anywhere else will throw an error and exit.
    java_import com.badlogic.gdx.utils.Timer

    $logger.info 'GameScreen#show'
    @fps_logger = FPSLogger.new
    @timer = Timer.new
    # https://github.com/jruby/jruby/wiki/CallingJavaFromJRuby#creating-anonymous-classes
    # Ugly as hell, but the only way to make an anonymous subclass due to the weird
    # behavior mentioned above.  If you try to create a subclass of Timer::Task
    # anywhere else it will crash.
    # All this for a damn timer. Yeesh.
    @save_task = @timer.scheduleTask(Class.new(com.badlogic.gdx.utils.Timer::Task) {
      def initialize(entity_manager)
        super()
        @em = entity_manager
      end

      def run
        $logger.info 'save_task'
      end
    }.new(nil), 1, 1)
  end

  def hide
    dispose
  end

  def render(delta)
    @fps_logger.log if $debug
    Gdx.gl.glClearColor(0, 0.7, 0, 1)
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)
    @camera.update
    @batch.setProjectionMatrix(@camera.combined)
    @rendering_system.process(@entity_manager, @camera, @batch)
  end

  def resize(w, h)
  end

  def pause
  end

  def resume
  end
end
