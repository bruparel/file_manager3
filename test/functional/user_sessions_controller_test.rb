require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "Current User" do

    setup do
      @user = Factory(:admin_user)
      set_current_user(@user)
    end

    context "on GET to :new" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        get :new
      end
      #should_render_a_form
      should respond_with(:success)
      should render_template(:new)
    end

    context "on POST to :create with valid credentials" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        post :create, :user_session => {:username => 'system', :password => 'important'}
      end
      should set_session(:user_credentials_id) { @user.id }
      should set_the_flash.to(/Logged in successfully./)
      should redirect_to("the client's list") { clients_path }
    end

    context "on POST to :create with wrong password" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        post :create, :user_session => {:username => 'system', :password => 'not_important'}
      end
      #should set_the_flash_to /Invalid login or password, or this account has been de-activated./
      should respond_with(:success)
      should render_template(:new)
    end

    context 'A logged_in user can reset' do
      setup do
        get :reset
      end
      should set_the_flash.to(/Current client unset.  Select a new client below./)
      should respond_with(:redirect)
      should redirect_to("clients page") { clients_path }
    end    

  end
  
end
