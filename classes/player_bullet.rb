class PlayerBullet < Bullet
  @@player_bullets = []
  def initialize(window,x,y)
    super
    @@player_bullets << self
  end

  def self.all
    @@player_bullets
  end

end

