require 'screens/menu'

class GameJam < Game

  def initialize
  end

  def create
    setScreen(MenuScreen.new(self))
  end

  def dispose
  end
end
