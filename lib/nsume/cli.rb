require 'erb'

module Nsume
  class Cli < Thor
    namespace 'nsume'
    map '-v' => :version

    desc 'init [PATH]', 'initializes a new nSume.'
    def init(path=Dir.pwd)
      path = '/Users/ogom/dev/github/nsume/tmp'
      src = Nsume.root.join('lib', 'generators').to_s + '/.'
      FileUtils.cp_r src, path

      src = ERB.new(File.read(File.expand_path('_config.yml.erb', path))).result
      File.write(File.expand_path('_config.yml', path), src)
      FileUtils.rm File.expand_path('_config.yml.erb', path)
    end

    desc 'version', 'Print the version and exit.'
    def version
      puts "nSume #{Nsume::VERSION}"
    end
  end
end
