class FireEnemy < Enemy
  @@fire_enemies = []
  def initialize(window,x_y)
    super
    @width = 26
    @height = 24
    @img = Gosu::Image.new(@window, "media/fire_enemy.png", true)
    @pattern = nil
    @facing = :left
    @@fire_enemies << self
  end

  private

  def movement
    5
  end
end

