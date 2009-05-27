class Logger
  def self.log(message,klass = self)
    puts "||#{klass} - #{Time.now} || #{message}" if Settings.LOGGER_VERBOSE == 'true'
  end
end

