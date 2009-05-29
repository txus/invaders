 class NormalEnemy < Enemy

  def initialize(window,x_y)
    super
    @width = 26
    @height = 23
    @img = Gosu::Image.new(@window, "media/normal_enemy.png", true)
    @pattern = nil
    @facing = :right
  end

  private

  def movement
    5
  end
end

