class RandomEvent
  @@random_events = Array.new
  def initialize (pps, &block)
    @ppm = ppm
    @block = block
    @@random_events << self
  end

  def call
    yield @block if (rand * 60).to_i < @ppm
  end

  def self.call_all
    @@random_events.each do |random_event|
      random_event.call
    end
  end
end

