class ScheduledEvent < Event
  @@scheduled_events = Array.new
  def initialize (seconds, &block)
    @seconds = seconds
    @block = block
    @active = true
    @last_called = Gosu::milliseconds
    @@scheduled_events << self
  end

  def call
    if (Gosu::milliseconds - @last_called) >= (@seconds * 1000) and @active == true then
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
    @@scheduled_events.delete self
  end

  def self.call_all
    @@scheduled_events.each do |scheduled_event|
      scheduled_event.call
    end
  end
end

