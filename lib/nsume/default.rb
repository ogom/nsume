module Nsume
  module Default
    JQUERY_ENDPOINT = 'https://code.jquery.com/jquery-1.10.2.min.js'.freeze
    JQUERY_FILE = 'jquery.min.js'.freeze

    BOOTSTRAP_ENDPOINT = 'https://raw.githubusercontent.com/twbs/bootstrap/v3.1.1'.freeze
    BOOTSTRAP_CSS_FILE = 'bootstrap.min.css'.freeze
    BOOTSTRAP_JS_FILE = 'bootstrap.min.js'.freeze

    BOOTSWATCH_ENDPOINT = 'https://raw.githubusercontent.com/thomaspark/bootswatch/v3.1.1'.freeze
    BOOTSWATCH_CSS_FILE = 'bootswatch.min.css'.freeze
    BOOTSWATCH_JS_FILE = 'bootswatch.js'.freeze
    BOOTSWATCH_THEME = 'yeti'.freeze

    class << self
      def options
        Hash[Nsume::Configure.keys.map{|key| [key, send(key)]}]
      end

      def jquery_endpoint
        JQUERY_ENDPOINT
      end

      def jquery_file
        JQUERY_FILE
      end

      def bootstrap_endpoint
        BOOTSTRAP_ENDPOINT
      end

      def bootstrap_css_file
        BOOTSTRAP_CSS_FILE
      end

      def bootstrap_js_file
        BOOTSTRAP_JS_FILE
      end

      def bootswatch_endpoint
        BOOTSWATCH_ENDPOINT
      end

      def bootswatch_css_file
        BOOTSWATCH_CSS_FILE
      end

      def bootswatch_js_file
        BOOTSWATCH_JS_FILE
      end

      def bootswatch_theme
        BOOTSWATCH_THEME
      end
    end
  end
end
