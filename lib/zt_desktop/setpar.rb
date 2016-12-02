################################################################################
#   setpar.rb
#
#   Sets default parameters (constants and global vars)
#
#   29.00.2016  ZT
#   01.12.2016  Updated
################################################################################

###   Globals Values   ###

# Constants
BLACK = 'black'.freeze
BLUE  = 'blue'.freeze
CYAN  = 'cyan'.freeze
GRAY  = 'grey'.freeze
GREY  = 'gray'.freeze
GREEN = 'green'.freeze
RED   = 'red'.freeze

TAB   = '  '        # Two spaces - to be used instead of \t
TAB2  = TAB  + TAB
TAB3  = TAB2 + TAB
TAB4  = TAB2 + TAB2
TAB5  = TAB4 + TAB
TAB6  = TAB5 + TAB

# Define GEM_PATH (e.g. /Users/zhenya/.gem/ruby/2.3.1/gems/zt_desktop-0.3.0)

dir = File.expand_path(File.dirname(__FILE__))

file_name = ''
until file_name == 'lib'
  dir       = File.dirname(dir)
  file_name = File.basename(dir)
end
GEM_PATH       =  File.dirname(dir)
TEMPLATES_PATH = File.join(GEM_PATH, 'templates')

# Variables

$relative_paths = [
  'app', 'app/controllers', 'app/models', 'app/views', 'app/views/members',
  'config', 'db', 'db/migrate', 'lib', 'logs'
]

# Special attribute cases (identified in *get_attributes*)
$references_names    = []
$password_attribute  = nil

# Enumerated options
$enum = []

# Debug flag
$debug = false
