class DoubleSpeedPerk < Perk
  attr_reader :type
  def initialize
    @type = self.class
  end

  def shooting_interval
    45
  end

  def shot_type
    :single
  end

end

