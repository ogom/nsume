require 'pathname'
require 'thor'

require_relative 'nsume/cli'
require_relative 'nsume/prepare'
require_relative 'nsume/version'
require_relative 'nsume/dev_helper'

module Nsume
  class << self
    def root
      @root ||= Pathname.new(File.expand_path('../', File.dirname(__FILE__)))
    end

    # TODO: move config
    def source_path
      path = Dir.pwd
      path = File.join(path, 'tmp') if File.exists?(File.join(path, 'nsume.gemspec'))
      path
    end

    def generators_path
      Nsume.root.join('lib', 'generators').to_s
    end

    def templates_path
      Nsume.root.join('lib', 'templates').to_s
    end

    def config_template
      File.read(File.expand_path('_config.yml.erb', Nsume.templates_path))
    end

    def posts_path
      path = File.expand_path('_posts', Nsume.source_path)
      FileUtils.mkdir_p(path) unless File.exists?(path)
      path
    end

    def post_template
      File.read(File.expand_path('post.md.erb', Nsume.templates_path))
    end
  end
end
