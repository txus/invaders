class NormalBullet < PlayerBullet
  def initialize(window,x,y, direction = :none)
    super
    @img = Gosu::Image.new(@window, "media/normal_bullet.png", true)
  end

  private

  def speed
    5
  end
end

