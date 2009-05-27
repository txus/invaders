class Perk
  attr_reader :type
  def initialize
    @type = nil
  end

  def shooting_interval
    raise NotImplementedError
  end

  def shot_type
    raise NotImplementedError
  end

end

