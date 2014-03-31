require 'logger'

module Nsume
  module Logger
    @@logger ||= ::Logger.new(STDOUT)
    @@logger.level = ::Logger::DEBUG
    @@logger.formatter = proc do |severity, datetime, progname, msg|
      "#{msg}\n"
    end

    class << self
      def info(message)
        @@logger.info(message)
      end

      def debug(message)
        @@logger.debug(message)
      end
    end
  end
end
