class NormalBullet < Bullet
  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/normal_bullet.png", true)
  end

  private

  def speed
    5
  end
end

