################################################################################
#   create_fs.rb
#
#   Creates File System for the App
#
#   30.11.2016  ZT
#   01.12.2016  Updated
################################################################################

module CreateFs
  Dir.mkdir "#{$app_root}", 0775 unless File.exist?($app_root)

  puts "Directories creating..."
  $relative_paths.each do |path|
    absolute_path = "#{$app_root}/#{path}"
    begin
      action_report path
      Dir.mkdir "#{absolute_path}", 0775
    rescue => e
      puts colored(RED, "Can't create directory:")
      puts "#{e}"
      exit
    end
  end
end

