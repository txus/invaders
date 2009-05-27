class NormalEnemy < Enemy
  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/normal_enemy.png", true)
    @pattern = nil
  end

  def move

  end

  private

  def speed
    5
  end
end

