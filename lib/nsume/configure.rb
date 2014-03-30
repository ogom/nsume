module Nsume
  module Configure
    class << self
      attr_accessor :jquery_endpoint, :jquery_file
      attr_accessor :bootstrap_endpoint, :bootstrap_css_file, :bootstrap_js_file
      attr_accessor :bootswatch_endpoint, :bootswatch_css_file, :bootswatch_js_file
      attr_accessor :bootswatch_theme
      attr_writer :dest_path

      def setup
        keys.each do |key|
          instance_variable_set(:"@#{key}", Nsume::Default.send(key))
        end
      end

      def keys
        @keys ||= %i[
          jquery_endpoint jquery_file
          bootstrap_endpoint bootstrap_css_file bootstrap_js_file
          bootswatch_endpoint bootswatch_css_file bootswatch_js_file
          bootswatch_theme
        ]
      end

      #
      # base reader
      #
      def assets_css
        'assets/css'
      end

      def assets_js
        'assets/js'
      end

      def generators_path
        Nsume.root.join('lib', 'generators').to_s
      end

      def templates_path
        Nsume.root.join('lib', 'templates').to_s
      end

      def config_template
        File.read(File.expand_path('_config.yml.erb', self.templates_path))
      end

      def navbar_template
        File.read(File.expand_path('navbar.yml', self.templates_path))
      end

      def post_template
        File.read(File.expand_path('post.md.erb', self.templates_path))
      end

      def themes
        ['amelia','cerulean','cosmo','cyborg','darkly','flatly','journal','lumen','readable','simplex','slate','spacelab','superhero','united','yeti']
      end

      #
      # custom reader
      #
      def dest_path
        @dest_path ||= Dir.pwd
        path = @dest_path
        path = File.join(path, 'tmp') if File.exists?(File.join(path, 'nsume.gemspec'))
        path
      end

      def posts_path
        path = File.expand_path('_posts', self.dest_path)
        FileUtils.mkdir_p(path) unless File.exists?(path)
        path
      end

      #
      # attr writer
      #
      def jquery_endpoint=(url)
        @jquery_endpoint = url
      end

      def bootstrap_endpoint=(url)
        @bootstrap_endpoint = url
      end

      def bootswatch_endpoint=(url)
        @bootswatch_endpoint = url
      end

      def bootswatch_theme=(theme)
        @bootswatch_theme = theme
      end
    end
  end
end
