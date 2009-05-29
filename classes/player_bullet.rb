class PlayerBullet < Bullet
  @@player_bullets = []
  def initialize(window,x,y, direction = :none)
    super
    @@player_bullets << self
  end

  def collides?(player)
    if @x >= player.x and @x <= player.x + player.width then
      if @y >= player.y and @y <= player.y + player.height then
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

