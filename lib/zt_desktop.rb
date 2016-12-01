################################################################################
#   zt_desktop.rb
#     Main Module to generate / update / destroy directories and files
#     for desktop application
#
#   29.11.2016  ZT (updated from zt_admin)
################################################################################
require 'zt_desktop/version'
require 'zt_desktop/setpar'
require 'zt_desktop/methods_pool'
require "zt_desktop/command_parser"

require 'active_support/inflector'   # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
require 'pp'
require "active_support/dependencies/autoload"

options = ZtDesktop::OptparseCommand.parse(ARGV)

ZtMethods.get_names options

if $mode == 'generate'
  require 'zt_desktop/create_fs'
  require 'zt_desktop/copy_files'
else
  require 'zt_desktop/remove_app'
end

module ZtDesktop
  # Just initial test
  class Greeting
    def self.hi
      puts "Hello world!"
    end
  end
end
