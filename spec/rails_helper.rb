ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production

abort('The Rails is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'spec_helper'
require 'shoulda/matchers'
require 'database_cleaner'
require 'vcr'
require 'webmock/rspec'

ActiveRecord::Migration.maintain_test_schema!

# Requiring support files
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods

  config.extend VCR::RSpec::Macros
end
