require 'screens/menu'
require 'screens/game'

class GameJam < Game
  def initialize
  end

  def create
    setScreen(GameScreen.new(self))
  end

  def dispose
  end
end
