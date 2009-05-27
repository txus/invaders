class EnemyBullet < Bullet
  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/enemy_bullet.png", true)
  end

  def move
    @y += speed
    Logger.log("Bullet is on #{@x} - #{@y}",self)
    destroy if @y >= @window.height
  end

  private

  def speed
    5
  end
end

