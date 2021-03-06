################################################################################
# Library of methods to generate Desktop App files
#
# 29.11.2016  ZT
################################################################################

require 'fileutils'

module ZtMethods
  ##############################################################################
  # Reports an action applied to a Directory / File
  ##############################################################################
  def action_report relative_path

    absolute_path = "#{$app_root}/#{relative_path}"

    if File.basename(relative_path).include?('.')   # It's a file
      if File.exist? absolute_path
        puts colored(BLUE,  "#{TAB}replace      ") + relative_path
      else
        puts colored(GREEN, "#{TAB}create       ") + relative_path
      end
    else                                            # It's a directory
      if File.exist? absolute_path
        puts colored(GREY,  "#{TAB}invoke     ") + relative_path
      else
        puts colored(GREEN, "#{TAB}create     ") + relative_path
      end
    end
  end

  ##############################################################################
  # Colorizes text for output to bash terminal
  ##############################################################################
  def colored flag, text
    case flag
      when BLACK
        index = 0
      when BLUE
        index = 34
      when CYAN
        index = 36
      when GREEN
        index = 32
      when GREY, GRAY
        index = 37
      when RED
        index = 31
    else
      index = 0
    end
    return "\e[#{index}m #{text}" + "\e[0m"
  end

  ##############################################################################
  # Debugging tool
  ##############################################################################
  def debug_printing options
    puts colored CYAN, "\nShow ARGV:"
    puts colored CYAN, ARGV

    puts colored CYAN, "\nShow options:"
    puts colored CYAN, options

    puts colored CYAN, "\nDebug *setpar*"
    puts colored CYAN, "$app_root          = #{$app_root}"
    puts colored CYAN, "admin shared path  = #{$admin_shared_path}"
    puts colored CYAN, "absolute view path = #{$absolute_views_path}"
    puts colored CYAN, "relative view path = #{$relative_views_path}"

    puts colored CYAN, "$name  = #{$name},  $names  = #{$names}"
    puts colored CYAN, "$model = #{$model}, $models = #{$models}"
  end

  ##############################################################################
  # Creates Admin views path for a Model
  ##############################################################################
  def create_views_path
    $relative_views_path = "app/views/admin/#{$names}"
    $absolute_views_path = "#{$app_root}/#{$relative_views_path}"
    action_report $relative_views_path

    FileUtils::mkdir_p($absolute_views_path) unless File.exist?($absolute_views_path)
  end

  ##############################################################################
  # Selects type of input field for a given Model attribute in a form_for helper
  ##############################################################################
  def field_type attr_name, attr_type
    case attr_type
      when 'boolean'
        return "check_box :#{attr_name}"

      when 'date'
        return "date_select(:#{attr_name}, order: [:day, :month, :year], selected: Date.today, use_month_names: ['января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября','декабря']) "

      when 'decimal'
        return "number_field :#{attr_name}, step: 0.01"

      when 'integer'
        if attr_name == 'active'
          return "radio_button :status, :active"
        elsif attr_name == 'archived'
          return "radio_button :status, :archived"
        else
          return "number_field :#{attr_name}"
        end

      when 'references'
        return "collection_select :#{attr_name}_id, sort_objects(@#{attr_name}s, :title), :id, :title, include_blank: false"
      when 'string'
        case attr_name
          when 'email'
            return "email_field :#{attr_name}"
          when 'password', 'password_confirmation'
            return "password_field :#{attr_name}"
          else
            return "text_field :#{attr_name}"
        end

      when 'text'
        return "text_area :#{attr_name}"
      else
        puts  colored(RED, "ERROR in field_type: UNDEFINED Attribute Type = '#{attr_type}' for attribute: '#{attr_name}'")
        return "BAD"
    end
  end

  ##############################################################################
  # Gets Model attributes aka arrays of names and types from the migration file
  ##############################################################################
  def get_attributes
    $attr_names = []
    $attr_types = []
    filename    = nil
    attributes  = []    # to be array aka:  ['string:name', 'integer:status']

    file_list   = Dir.entries($migrate_path)

    file_list.each do |f|
      filename = f if f.include? "create_#{$names}"   # find a proper migration file
    end

    if filename
      file_in = File.open("#{$migrate_path}/#{filename}", 'r')
      lines   = file_in.readlines

      # Collect attributes parsing lines of a migration file
      lines.each do |line|
        if line.match("t.") && !line.match("t.timestamps") && !line.match("create_table") && !line.match("class") && !line.match("add_index") &&!line.match("add_foreign_key")

          # remove non-attribute text
          if line.match(",")            # aka:  t.boolean :stock, default: true
            buffer = line.split(",")
            line   = buffer.first       # Cut off text e.g: ", index: true"
          end

          line = line.strip.sub('t.', '').gsub(' ', '')  # line to contain:  string:name

          attributes << line
        end
      end

      # Split attributes array into names and types arrays
      attributes.each do |attribute|
        pair         = attribute.split(":")
        $attr_types << pair.first.rstrip
        $attr_names << pair.last.rstrip

        # Identify special cases
        $references_names  << pair.last if pair.first == 'references'
        $password_attribute = true      if pair.first == 'password'
      end
    else
      puts colored(RED, "Файл миграции для модели #{$model} не найден")
      exit
    end
  end

  ##############################################################################
  # Gets App name
  ##############################################################################
  def self.get_names options

    # ARGV[0] must be the procedure *mode*
    case ARGV[0]
      when 'g', 'generate'
        $mode = 'generate'
      when 'd', 'destroy'
        $mode = 'destroy'
      else
        puts colored(RED, "First argument must be g[enerate] or d[estroy]")
        exit
    end

    if ARGV[1].nil?
      puts colored(RED, "Second argument must be <app_name>")
      exit
    end

    # Define App name & path
    $project_name = ARGV[1]
    upper_count   = $project_name.scan(/\p{Upper}/).count  # Number of uppercase characters

    if upper_count > 1                # Compound name (e.g. RedWineGlass)
      $app_name = ARGV[1][0].downcase
      string    = ARGV[1][1..-1]
      string.chars do |c|
        if c.match(/\p{Upper}/)
          $app_name << '_' << c.downcase
        else
          $app_name << c
        end
      end
    else                              # Simple name (e.g. Myapp)
      $app_name   = ARGV[1].downcase       # e.g.  city
    end

    # App paths
    parent_dir = `pwd`.chomp    # chomp without arguments removes "\n" or "\r\n" if any
    $app_root  = "#{parent_dir}/#{$app_name}"

    # Enumerated options
    #$enum = options[:enum] if options[:enum].size > 0
  end
end