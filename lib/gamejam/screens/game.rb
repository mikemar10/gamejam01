require 'components/component'
require 'components/gravity'
require 'components/player_input'
require 'components/position'
require 'components/renderable'
require 'components/tile'
require 'entity_manager'
require 'systems/rendering_system'
require 'systems/input_system'
require 'systems/tile_system'

class GameScreen
  include Screen

  attr_accessor :time

  def initialize(game)
    $debug = false
    @time = []
    @game = game
    @entity_manager = EntityManager.new
    @rendering_system = RenderingSystem.new(self)
    @input_system = InputSystem.new(self)
    @tile_system = TileSystem.new(self)
    @camera = OrthographicCamera.new
    @camera.setToOrtho(false, $screen_width, $screen_height)
    @batch = SpriteBatch.new
    @player = @entity_manager.create_entity({
      tags: ['player'],
      components: [
        Position.new(rand(1280), rand(720)),
        Renderable.new("assets/libgdx.png"),
        PlayerInput.new([P1_KEY_UP, P1_KEY_DOWN, P1_KEY_LEFT, P1_KEY_RIGHT, P1_KEY_TIME_TRAVEL])
      ]})

    @map = TmxMapLoader.new.load("assets/test_map.tmx")
    layer = @map.layers.first
    (0..layer.width).each do |x|
      (0..layer.height).each do |y|
        tile = layer.get_cell(x, y)
        unless tile.nil?
          tile = tile.tile
          @entity_manager.create_entity({
            tags: ['tile'],
            components: [
              Tile.new(x * layer.tile_width, y * layer.tile_height, tile.texture_region)
            ]})
        end
      end
    end

    save_point_in_time
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
      def initialize(game)
        super()
        @game = game
      end

      def run
        @game.save_point_in_time
      end
    }.new(self), 1, 1)
  end

  def hide
    dispose
  end

  def render(delta)
    @fps_logger.log if $debug
    Gdx.gl.glClearColor(0, 0.7, 0, 1)
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)
    player_position = @entity_manager.position_components[@player]
    @camera.position.set(player_position.x, player_position.y, 0)
    @camera.update
    @batch.setProjectionMatrix(@camera.combined)
    @input_system.process(@entity_manager, delta)
    @rendering_system.process(@entity_manager, @batch)
    @tile_system.process(@entity_manager, @batch)
  end

  def resize(w, h)
  end

  def pause
  end

  def resume
  end

  def save_point_in_time
    @time << Marshal::dump(@entity_manager)
  end

  def travel_back_twenty_seconds
    $logger.info "TIME TRAVEL TIME"
    if @time.length < 20
      @entity_manager = Marshal::load(@time.first)
      @time = @time[0..0]
    else
      @entity_manager = Marshal::load(@time[-20])
      @time.pop(20)
    end
  end
end
