class DefaultPerk < Perk
  attr_reader :type
  def initialize
    @type = self.class
  end

  def shooting_interval
    150
  end

  def shot_type
    :single
  end

end

