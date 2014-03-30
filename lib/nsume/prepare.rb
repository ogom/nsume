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

          self.navbar options['site']
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

      def navbar(site='')
        yaml = []

        YAML.load(Nsume.config.navbar_template).each do |nav|
          case site
          when 'user', 'blog'
            case nav['label'].downcase
            when 'blog', 'documentation'
              yaml << nav
            end
          when 'project', 'changelog'
            case nav['label'].downcase
            when 'changelog', 'documentation'
              yaml << nav
            end
          when 'api'
            case nav['label'].downcase
            when 'api', 'changelog', 'documentation'
              yaml << nav
            end
          end
        end

        path = File.join(Nsume.config.dest_path, '_data', 'navbar.yml')
        File.write(path, YAML.dump(yaml))
      end

      private

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
