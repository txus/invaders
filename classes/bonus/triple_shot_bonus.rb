class TripleShotBonus < Bonus

  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/triple_shot_bonus.png", true)
    @perk = TripleShotPerk
    @duration = 2
  end

  private

  def speed
    4
  end

end

