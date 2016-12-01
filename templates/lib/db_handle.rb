require 'yaml'
require 'logger'
require 'active_record'

class DbHandle

  # Log file
  $LOG = Logger.new(File.open('logs/db.log', 'w'))

  # Get config parameters
  @config = YAML.load_file('config/database.yml')['development']

  def self.close db
    begin
      ActiveRecord::Base.remove_connection(db)
      $LOG.debug "DB connection removed" if @config['logger']
    rescue SQLite3::Exception => e
      $LOG.logger.error("#{e}")
      puts "Exception occurred:  #{e}"
    end
  end

  def self.create
    begin
      # Creates database in memory. So it is not permanent.
      #@db = SQLite3::Database.new ":memory:"

      # creates a real database
      db = SQLite3::Database.new @config['database']

      $LOG.debug "DB created" if @config['logger']
      $LOG.debug "SQLite version used: #{db.get_first_value 'SELECT SQLITE_VERSION()'}" if @config['logger']

    rescue SQLite3::Exception => e
      $LOG.logger.error("#{e}")
      puts "Exception occurred:  #{e}"
    ensure
      db.close if db
    end
  end

  def self.open
    begin
      ActiveRecord::Base.establish_connection @config
      $LOG.debug "DB connection established" if @config['logger']
    rescue SQLite3::Exception => e
      $LOG.logger.error("#{e}")
      puts "Exception occurred:  #{e}"
    end
  end
end

