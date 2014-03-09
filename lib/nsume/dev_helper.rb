require 'logger'
require 'pp'

module Nsume
  module DevHelper
    @@logger ||= Logger.new(STDOUT)
    @@logger.level = Logger::DEBUG

    class << self
      def log(message )
        @@logger.info(message)
      end

      def mlog(method)
        @@logger.debug("Method is [#{method}]")
      end

      def elog(path)
        @@logger.debug("File [#{File.basename(path)}] exists [#{File.exists?(path)}]")
      end
    end
  end
end
