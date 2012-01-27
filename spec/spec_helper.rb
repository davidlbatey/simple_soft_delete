$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'simple_soft_delete'
require 'active_record'
require 'database_cleaner'

require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/bar')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  def connect(environment)
    conf = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
    ActiveRecord::Base.establish_connection(conf[environment])
  end

  connect('test')

  load(File.dirname(__FILE__) + "/schema.rb")

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
