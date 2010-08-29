ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "authlogic/test_case" # include at the top of test_helper.rb
require 'shoulda'
require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + "/factories")

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# useful method for functional tests that require an authenticated user
def set_current_user(this_user)
  #@user = Factory(:user)
  @controller.stub!(:current_user, :return => this_user)
end
