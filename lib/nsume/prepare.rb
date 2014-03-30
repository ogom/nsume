require 'faraday'

module Nsume
  module Prepare
    class << self
      def generator(options={})
        Nsume::DevHelper.mlog __method__

        path = File.expand_path('_config.yml', Nsume.config.dest_path)
        unless File.exists?(path)
          FileUtils.cp_r Nsume.config.generators_path + '/.', Nsume.config.dest_path

          basename = File.basename(Nsume.config.dest_path)
          baseurl = '/' + basename if options['site'] == 'project'
          year = Time.now.year

          file = ERB.new(Nsume.config.config_template).result(binding)
          File.write(path, file)

          navbar options['navbar']
        end

        Nsume::DevHelper.elog path
      end

      def jquery
        asset Nsume.config.assets_js, Nsume.config.jquery_file, Nsume.config.jquery_endpoint
      end

      def bootstrap_js
        endpoint = [Nsume.config.bootstrap_endpoint, 'dist', 'js', Nsume.config.bootstrap_js_file].join('/')
        asset Nsume.config.assets_js, Nsume.config.bootstrap_js_file, endpoint
      end

      def bootswatch_css
        endpoint = [Nsume.config.bootswatch_endpoint, Nsume.config.assets_css, Nsume.config.bootswatch_css_file].join('/')
        asset Nsume.config.assets_css, Nsume.config.bootswatch_css_file, endpoint
      end

      def bootswatch_js
        endpoint = [Nsume.config.bootswatch_endpoint, Nsume.config.assets_js, Nsume.config.bootswatch_js_file].join('/')
        asset Nsume.config.assets_js, Nsume.config.bootswatch_js_file, endpoint
      end

      def bootswatch_theme(theme='')
        theme ||= Nsume.config.bootswatch_theme
        path = File.join(Nsume.config.assets_css, 'themes', theme)
        endpoint = [Nsume.config.bootswatch_endpoint, theme, Nsume.config.bootstrap_css_file].join('/')
        asset path, Nsume.config.bootstrap_css_file, endpoint
      end

      private

      def navbar(theme='')
        raw = []
        path = File.join(Nsume.config.dest_path, '_data', 'navbar.yml')

        YAML.load_file(path).each do |nav|
          case theme
          when 'blog'
            case nav['label'].downcase
            when 'blog', 'documentation'
              raw << nav
            end
          when 'api'
            case nav['label'].downcase
            when 'api', 'changelog', 'documentation'
              raw << nav
            end
          end
        end

        file = YAML.dump(raw)
        File.write(path, file)
      end

      def asset(path, file, endpoint)
        Nsume::DevHelper.mlog __method__
        Nsume::DevHelper.log endpoint

        path = File.expand_path(path, Nsume.config.dest_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)

        path = File.expand_path(File.join(path, file), Nsume.config.dest_path)
        unless File.exists?(path)
          file = Faraday.get(endpoint).body
          File.write(path, file)
        end

        Nsume::DevHelper.elog path
      end
    end
  end
end
