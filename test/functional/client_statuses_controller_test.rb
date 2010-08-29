require 'test_helper'

class ClientStatusesControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "on GET to :index" do
    setup do
      @admin = Factory(:admin_user)
      set_current_user(@admin)
      get :index
    end
    should assign_to(:client_statuses)
    should assign_to(:search_fields_array)
    #should_render_a_form
    should respond_with(:success)
    should render_template(:index)
  end

  context "on GET to :new" do
    setup do
      @admin = Factory(:admin_user)
      get :new, {}, {:user_id => @admin.id}
    end
    should_not set_the_flash
    should assign_to(:client_status)
    #should_render_a_form
    should respond_with(:success)
    should render_template(:new)
  end

  context "on GET to :edit for client status record" do
    setup do
      @admin = Factory(:admin_user)
      @client_status = Factory(:client_status)
      get :edit, {:id => @client_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:client_status)
    should respond_with(:success)
    should render_template(:edit)
    should_not set_the_flash
  end

  context "on PUT to :update an existing client status record" do
    setup do
      @admin = Factory(:admin_user)
      @client_status = Factory(:client_status)
      put :update, { :id => @client_status.id, :client_status => {:name => 'New Status'}},
                   {:user_id => @admin.id}
    end
    should "Keep the client status count to 1 upon update" do
      assert_equal 1, ClientStatus.count
    end
    should set_session(:user_id) { @admin.id }
    should assign_to(:client_status)
    should set_the_flash.to(/Client status was successfully updated./)
    should redirect_to("the client statuses' list") { client_statuses_path }
  end

  context "on GET to :show for an existing client status record" do
    setup do
      @admin = Factory(:admin_user)
      @client_status = Factory(:client_status)
      get :show, {:id => @client_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:client_status)
    should respond_with(:success)
    should render_template(:show)
    should_not set_the_flash
  end

  context 'on DELETE to :destroy for a client status record' do
    setup do
      @admin = Factory(:admin_user)
      @client_status = Factory(:client_status)
      delete :destroy, {:id => @client_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:client_status)
    should set_the_flash.to(/Client status sucessfully destroyed/)
    should respond_with(:redirect)
    should redirect_to("Client statuses' list") {client_statuses_path }
  end

end
