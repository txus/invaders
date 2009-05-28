class RandomEvent < Event
  @@random_events = Array.new
  def initialize (ppm, &block)
    @ppm = ppm
    @block = block
    @@random_events << self
  end

  def call
    @block.call if (rand * 10000).to_i < @ppm
  end

  def self.call_all
    @@random_events.each do |random_event|
      random_event.call
    end
  end
end

