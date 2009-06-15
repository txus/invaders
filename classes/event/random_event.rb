class RandomEvent < Event
  @@random_events = Array.new
  def initialize (seconds, chance, &block)
    @seconds = seconds
    @chance = chance.to_f
    @block = block
    @active = true
    @last_called = Gosu::milliseconds
    @@random_events << self
  end

  def call
    if (Gosu::milliseconds - @last_called) >= (@seconds * 1000) and rand.to_f < @chance.to_f and @active == true then
      @block.call
      @last_called = Gosu::milliseconds
    end
  end

  def stop
    @active = false
  end

  def resume
    @active = true
  end

  def destroy
    @@random_events.delete self
  end

  def self.call_all
    @@random_events.each do |random_event|
      random_event.call
    end
  end
end

