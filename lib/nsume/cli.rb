module Nsume
  class Cli < Thor
    namespace 'nsume'
    map '-v' => :version

    desc 'version', 'Print the version and exit.'
    def version
      puts "nSume #{Nsume::VERSION}"
    end
  end
end
