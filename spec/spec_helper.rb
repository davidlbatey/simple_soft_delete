# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'active_record'
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')

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

end
