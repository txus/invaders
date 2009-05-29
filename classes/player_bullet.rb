class PlayerBullet < Bullet
  @@player_bullets = []
  def initialize(window,x,y, direction = :none)
    super
    @@player_bullets << self
  end

  def collides?(enemy)
    if @x >= enemy.x and @x <= enemy.x + enemy.width then
      if @y >= enemy.y and @y <= enemy.y + enemy.height then
        @window.player.score(Score.for?(enemy.class))
        true
      end
    else
      false
    end
  end

  def self.all
    @@player_bullets
  end

end

