class Score
  def self.for?(klass)
    case klass.name
    when "NormalEnemy" then
      10
    when "FireEnemy" then
      20
    else
      0
    end
  end
end

