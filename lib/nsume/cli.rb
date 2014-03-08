require 'erb'
require 'faraday'

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

      src = Faraday.get("https://code.jquery.com/jquery-1.10.2.min.js").body
      File.write(File.expand_path('assets/jquery/jquery-1.10.2.min.js', path), src)

      FileUtils.mkdir_p(File.expand_path('assets/bootstrap/dist/js', path))
      src = Faraday.get("https://raw.github.com/twbs/bootstrap/v3.1.1/dist/js/bootstrap.min.js").body
      File.write(File.expand_path('assets/bootstrap/dist/js/bootstrap.min.js', path), src)

      FileUtils.mkdir_p(File.expand_path('assets/bootswatch/css', path))
      src = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v3.1.1/assets/css/bootswatch.min.css").body
      File.write(File.expand_path('assets/bootswatch/css/bootswatch.min.css', path), src)

      FileUtils.mkdir_p(File.expand_path('assets/bootswatch/js', path))
      src = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v3.1.1/assets/js/bootswatch.js").body
      File.write(File.expand_path('assets/bootswatch/js/bootswatch.js', path), src)

      FileUtils.mkdir_p(File.expand_path('assets/themes/flatly', path))
      src = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v3.1.1/flatly/bootstrap.min.css").body
      File.write(File.expand_path('assets/themes/flatly/bootstrap.min.css', path), src)
    end

    desc 'version', 'Print the version and exit.'
    def version
      puts "nSume #{Nsume::VERSION}"
    end
  end
end
