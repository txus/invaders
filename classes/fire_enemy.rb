class FireEnemy < Enemy
  def initialize(window,x_y)
    super
    @width = 26
    @height = 24
    @img = Gosu::Image.new(@window, "media/fire_enemy.png", true)
    @pattern = nil
  end

  def move

  end

  private

  def speed
    5
  end
end

