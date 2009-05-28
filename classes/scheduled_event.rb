class ScheduledEvent < Event
  @@scheduled_events = Array.new
  def initialize (seconds, &block)
    @seconds = seconds
    @block = block
    @last_called = Gosu::milliseconds
    @@scheduled_events << self
  end

  def call
    if (Gosu::milliseconds - @last_called) >= (@seconds * 1000) then
      @block.call
      @last_called = Gosu::milliseconds
    end
  end

  def self.call_all
    @@scheduled_events.each do |scheduled_event|
      scheduled_event.call
    end
  end
end

