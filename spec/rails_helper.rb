require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RAILS_ENV'] ||= 'test'
  require 'spec_helper'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'database_cleaner'
  require 'elasticsearch/extensions/test/cluster'
  # Add additional requires below this line. Rails is not loaded until this point!

  # Requires supporting ruby files with custom matchers and macros, etc, in
  # spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
  # run as spec files by default. This means that files in spec/support that end
  # in _spec.rb will both be required and run as specs, causing the specs to be
  # run twice. It is recommended that you do not name files matching this glob to
  # end with _spec.rb. You can configure this pattern with the --pattern
  # option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
  #
  # The following line is provided for convenience purposes. It has the downside
  # of increasing the boot-up time by auto-requiring all files in the support
  # directory. Alternatively, in the individual `*_spec.rb` files, manually
  # require only the support files necessary.
  #
  # Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # config.use_transactional_fixtures = true

    # RSpec Rails can automatically mix in different behaviours to your tests
    # based on their file location, for example enabling you to call `get` and
    # `post` in specs under `spec/controllers`.
    #
    # You can disable this behaviour by removing the line below, and instead
    # explicitly tag your specs with their type, e.g.:
    #
    #     RSpec.describe UsersController, :type => :controller do
    #       # ...
    #     end
    #
    # The different available types are documented in the features, such as in
    # https://relishapp.com/rspec/rspec-rails/docs
    config.infer_spec_type_from_file_location!

    # for test
    config.include Capybara::DSL

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # Elasticsearch test setting
    config.before(:all, :elasticsearch) do
      Elasticsearch::Extensions::Test::Cluster.start(nodes: 1) unless Elasticsearch::Extensions::Test::Cluster.running?
    end

    config.after(:all, :elasticsearch) do
      Elasticsearch::Extensions::Test::Cluster.stop if Elasticsearch::Extensions::Test::Cluster.running?
    end
  end

  def elasticsearch_create_index_and_import
    Commit.__elasticsearch__.create_index! force: true
    Commit.import
    sleep 1
  end

  def elasticsearch_delete_index
    Commit.__elasticsearch__.client.indices.delete index: Commit.index_name
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
