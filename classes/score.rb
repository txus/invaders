class Score
  def self.for?(klass)
    case klass.name
    when "NormalEnemy":
      10
    when "FireEnemy":
      20
    else
      0
    end
  end
end

