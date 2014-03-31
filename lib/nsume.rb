require 'pathname'
require 'thor'

require_relative 'nsume/configure'
require_relative 'nsume/default'
require_relative 'nsume/cli'
require_relative 'nsume/prepare'
require_relative 'nsume/version'
require_relative 'nsume/logger'

module Nsume
  class << self
    def configure
      yield Nsume::Configure
    end

    def config
      Nsume::Configure
    end

    def root
      @root ||= Pathname.new(File.expand_path('../', File.dirname(__FILE__)))
    end
  end
end

Nsume::Configure.setup
