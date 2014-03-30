require 'date'
require 'erb'
require 'yaml'

module Nsume
  class Cli < Thor
    namespace 'nsume'
    map '-v' => :version
    map '-sw' => :switch

    method_option :site, type: :string, aliases: '-s', default: 'user', desc: 'Site [user] or [project]'
    method_option :navbar, type: :string, aliases: '-n', default: 'blog', desc: 'Site navbar [blog] or [api]'
    method_option :theme, type: :string, aliases: '-t', default: 'flatly', desc: 'Site theme'
    desc 'init [PATH]', 'initializes a new nSume.'
    def init(path=Dir.pwd)
      Nsume::DevHelper.mlog __method__

      Nsume.config.dest_path = path

      Nsume::Prepare.generator options
      Nsume::Prepare.jquery
      Nsume::Prepare.bootstrap_js
      Nsume::Prepare.bootswatch_css
      Nsume::Prepare.bootswatch_js
      Nsume::Prepare.bootswatch_theme options['theme']

      Nsume::DevHelper.log "Finished setting."
    end

    desc 'post [TITLE] [CONTENT]', 'Creates a posts.'
    def post(title='title', content='')
      Nsume::DevHelper.mlog __method__

      name = "#{Date.today.strftime("%Y-%m-%d")}-#{title}.md"
      path = File.expand_path(name, Nsume.config.posts_path)
      file = ERB.new(Nsume.config.post_template).result(binding)
      File.write(path, file)

      Nsume::DevHelper.log "Created a posts."
    end

    desc 'switch [THEME]', 'Switch theme'
    def switch(theme)
      Nsume::DevHelper.mlog __method__

      path = File.join(Nsume.config.dest_path, '_config.yml')
      raw = YAML.load_file(path)
      raw['theme'] = theme
      file = YAML.dump(raw)
      File.write(path, file)

      Nsume::Prepare.bootswatch_theme theme
    end

    desc 'theme', 'Show the current theme'
    def theme
      path = File.join(Nsume.config.dest_path, '_config.yml')
      raw = YAML.load_file(path)
      puts raw['theme']
    end

    desc 'themes', 'List all themes'
    def themes
      puts [
        'amelia',
        'cerulean',
        'cosmo',
        'cyborg',
        'flatly',
        'journal',
        'lumen',
        'readable',
        'simplex',
        'slate',
        'spacelab',
        'superhero',
        'united',
        'yeti'
      ]
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
