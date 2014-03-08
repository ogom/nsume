require 'pathname'
require 'thor'

require_relative 'nsume/cli'
require_relative 'nsume/version'

module Nsume
  class << self
    def root
      @root ||= Pathname.new(File.expand_path('../', File.dirname(__FILE__)))
    end
  end
end
