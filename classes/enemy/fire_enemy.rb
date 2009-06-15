class FireEnemy < Enemy
  def initialize(window,x_y)
    super
    @width = 26
    @height = 24
    @img = Gosu::Image.new(@window, "media/fire_enemy.png", true)
    @pattern = nil
    @facing = :left
  end

  def shoot
    direction = [:left,:none,:right].shuffle.first
    EnemyFireBullet.new(@window,@x + (@width / 2), @y + @height, direction)
    Logger.log("Enemy shot bullet", self)
  end

  private

  def movement
    5
  end
end

