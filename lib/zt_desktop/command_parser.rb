################################################################################
#   command_parser.rb
#     Command line options analysis on a base of Ruby OptionParser class
#
#     ref: http://ruby-doc.org/stdlib-2.2.0/libdoc/optparse/rdoc/OptionParser.html#top
#
#   29.11.2016  ZT (from zt_admin)
################################################################################
require 'optparse'
require 'optparse/time'
require 'ostruct'

include ZtMethods

module ZtDesktop
  class OptparseCommand

    # Returns a structure describing the Command options
    def self.parse(args)
      if args.size == 0
        puts colored RED, "Not enough arguments. To learn the command use options: -h or --help"
        exit
      end

      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.enum = []

      opt_parser = OptionParser.new do |opts|
        opts.banner =
          "\nUsage:#{TAB2}zt_desktop [g | generate] <AppNameme> [options]\n#{TAB5}zt_desktop {d | destroy} <AppName>\nExamples: zt_desktop g RedWineGlass -d\n#{TAB5}zt_desktop destroy MyApp"

        opts.separator ""
        opts.separator "Specific options:"

        # Mandatory argument.
#        opts.on("-e", "--enum ENUMERATED ATTRIBUTE",
#                "Requires the Model enum attribute for input field in a view form") do |enum|
#          options.enum << enum
#        end

        opts.separator ""
        opts.separator "Common options:"

        # Debug flag: no arguments
        opts.on("-d", "--debug", "Debug printing is ON") do
          $debug = true
        end

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "--help", "Show help message (this one)") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("-v", "--version", "Show version") do
          puts VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end           # parse()
  end             # class OptparseCommand
end