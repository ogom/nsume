require 'date'
require 'erb'
require 'yaml'

module Nsume
  class Cli < Thor
    namespace 'nsume'
    map '-v' => :version
    map '-sw' => :switch

    method_option :site, type: :string, aliases: '-s', default: 'user', desc: 'Site [user] or [project]'
    method_option :theme, type: :string, aliases: '-t', default: 'flatly', desc: 'Site theme'
    desc 'init [PATH]', 'initializes a new nSume.'
    def init(path=Dir.pwd)
      Nsume.config.dest_path = path

      Nsume::Prepare.generator options
      Nsume::Prepare.jquery
      Nsume::Prepare.bootstrap_js
      Nsume::Prepare.bootswatch_css
      Nsume::Prepare.bootswatch_js
      Nsume::Prepare.bootswatch_theme options['theme']

      Nsume::Logger.info "Successfully initialized."
    end

    desc 'post [TITLE] [CONTENT]', 'Creates a posts.'
    def post(title='title', content='')
      name = "#{Date.today.strftime("%Y-%m-%d")}-#{title}.md"
      path = File.expand_path(name, Nsume.config.posts_path)
      unless File.exists?(path)
        file = ERB.new(Nsume.config.post_template).result(binding)
        File.write(path, file)
        Nsume::Logger.info "Created a posts."
      else
        Nsume::Logger.info "Existed a posts."
      end
    end

    desc 'switch [THEME]', 'Switch theme'
    def switch(theme)
      path = File.join(Nsume.config.dest_path, '_config.yml')
      raw = YAML.load_file(path)
      raw['theme'] = theme
      file = YAML.dump(raw)
      File.write(path, file)

      Nsume::Prepare.bootswatch_theme theme
      Nsume::Logger.info "Switched theme."
    end

    desc 'theme', 'Show the current theme'
    def theme
      path = File.join(Nsume.config.dest_path, '_config.yml')
      raw = YAML.load_file(path)
      puts raw['theme']
    end

    desc 'themes', 'List all themes'
    def themes
      puts Nsume.config.themes
    end

    desc 'navbar [SITE]', 'Site navbar [blog] or [project] or [api]'
    def navbar(site='blog')
      Nsume::Prepare.navbar site
    end

    desc 'up', 'Start jekyll server.'
    def up
      system "cd #{Nsume.config.dest_path} && jekyll server --watch --baseurl ''"
    rescue Interrupt
    end

    desc 'version', 'Print the version and exit.'
    def version
      puts "nSume #{Nsume::VERSION}"
    end
  end
end
