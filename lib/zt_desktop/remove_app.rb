################################################################################
#   remove_app.rb
#
#   Remove App
#
#   30.00.2016  ZT
################################################################################
require 'fileutils'

print "Remove the Application #{$project_name} (y/n)? "
answer = $stdin.getc.chomp

if answer == 'y'
  begin
    FileUtils.rm_r $app_root
    puts colored(GREEN, "Directory #{$app_root} deleted")
  rescue => e
    puts colored(RED, "Can't remove directory:")
    puts "#{e}"
  end
end


