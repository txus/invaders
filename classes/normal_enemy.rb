class NormalEnemy < Enemy
  @@normal_enemies = []
  def initialize(window,x_y)
    super
    @width = 26
    @height = 23
    @img = Gosu::Image.new(@window, "media/normal_enemy.png", true)
    @pattern = nil
    @facing = :right
    @@normal_enemies << self
  end

  def self.move_all
    @@normal_enemies.each do |normal_enemy|
      normal_enemy.move
    end
  end

  private

  def movement
    5
  end
end

