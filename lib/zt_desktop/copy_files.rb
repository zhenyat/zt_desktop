################################################################################
#   copy_files.rb
#
#   Copies files to the Desktop App from templates
#
#   01.12.2016  ZT
################################################################################
require 'fileutils'

module CopyFiles
  # Templates content
  dirs_and_files = Dir[File.join(TEMPLATES_PATH, '**', '*')]      # Get dirs & files
  source_files   = dirs_and_files.reject{|d| File.directory? d}   # Reject dirs

  # Copy files
  puts "Files creating..."
  source_files.each do |file|
    relative_path = file.gsub("#{TEMPLATES_PATH}/", "")
    dst_dir       = File.join($app_root, File.dirname(relative_path))
    begin
      action_report relative_path
      FileUtils.cp(file, dst_dir)
    rescue => e
      puts colored(RED, "Can't create directory:")
      puts "#{e}"
      exit
    end
  end
end
