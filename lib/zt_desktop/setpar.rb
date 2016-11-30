################################################################################
#   setpar.rb
#
#   Sets default parameters (constants and global vars)
#
#   29.00.2016  ZT
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

## Some variables ?? ##
#
# Special attribute cases (identified in *get_attributes*)
$references_names    = []
$password_attribute  = nil

# Enumerated options
$enum = []

# Debug flag
$debug = false
