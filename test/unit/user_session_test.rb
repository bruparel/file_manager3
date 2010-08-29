require 'test_helper'
class UserSessionTest  < ActiveSupport::TestCase
  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context 'An existing user instance with proper login credentials' do
    setup do
      @user = Factory(:admin_user)
      activate_authlogic # run before tests are executed
    end

    should 'be able to authenticate' do
      # with both username and password correct
      @user_session = UserSession.create({:username => 'system', :password => 'important'})
      assert_equal(@user_session.user, @user)
    end
  end

  context 'An existing user instance with improper login credentials' do
    setup do
      @user = Factory(:admin_user)
      activate_authlogic # run before tests are executed
    end

    should 'be able to authenticate' do
      # with right username but bad password
      @user_session = UserSession.new({:username => 'system', :password => 'unimportant'})
      assert_equal(false, @user_session.save)
    end
  end  

end