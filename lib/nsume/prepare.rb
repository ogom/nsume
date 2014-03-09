module Nsume
  module Prepare
    # Todo: default configure
    class << self
      def generator(options)
        Nsume::DevHelper.mlog __method__

        name = '_config.yml'
        path = File.expand_path(name, Nsume.source_path)
        unless File.exists?(path)
          FileUtils.cp_r Nsume.generators_path + '/.', Nsume.source_path
          file = ERB.new(Nsume.config_template).result(binding)
          File.write(path, file)

          raw = []
          path = File.join(Nsume.source_path, '_data', 'navbar.yml')
          YAML.load_file(path).each do |navbar|
            case options['navbar']
            when 'blog'
              case navbar['lavel'].downcase
              when 'blog', 'documentation'
                raw << navbar
              end
            when 'api'
              case navbar['lavel'].downcase
              when 'api', 'changelog', 'documentation'
                raw << navbar
              end
            end
          end
          file = YAML.dump(raw)
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end

      def jquery(version='1.10.2')
        Nsume::DevHelper.mlog __method__

        name = "jquery-#{version}.min.js"
        path = File.expand_path('assets/jquery', Nsume.source_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, name), Nsume.source_path)
        unless File.exists?(path)
          file = Faraday.get("https://code.jquery.com/#{name}").body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end

      def bootstrap(version='3.1.1')
        Nsume::DevHelper.mlog __method__

        name = 'bootstrap.min.js'
        path = File.expand_path('assets/bootstrap/dist/js', Nsume.source_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, name), Nsume.source_path)
        unless File.exists?(path)
          file = Faraday.get("https://raw.github.com/twbs/bootstrap/v#{version}/dist/js/#{name}").body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end

      def bootswatch_css(version='3.1.1')
        Nsume::DevHelper.mlog __method__

        name = 'bootswatch.min.css'
        path = File.expand_path('assets/bootswatch/css', Nsume.source_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, name), Nsume.source_path)
        unless File.exists?(path)
          file = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v#{version}/assets/css/#{name}").body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end

      def bootswatch_js(version='3.1.1')
        Nsume::DevHelper.mlog __method__

        name = 'bootswatch.js'
        path = File.expand_path('assets/bootswatch/js', Nsume.source_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, name), Nsume.source_path)
        unless File.exists?(path)
          file = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v#{version}/assets/js/#{name}").body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end

      def bootswatch_theme(theme='flatly', version='3.1.1')
        Nsume::DevHelper.mlog __method__

        name = 'bootstrap.min.css'
        path = File.expand_path("assets/themes/#{theme}", Nsume.source_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, name), Nsume.source_path)
        unless File.exists?(path)
          file = Faraday.get("https://raw.github.com/thomaspark/bootswatch/v#{version}/#{theme}/#{name}").body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end
    end
  end
end
