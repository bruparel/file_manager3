require 'test_helper'

class BaseFoldersControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}
  
  context "on GET to :index" do
    setup do
      @admin = Factory(:admin_user)
      set_current_user(@admin)
      get :index
    end
    should assign_to(:base_folders)
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
    should assign_to(:base_folder)
    #should_render_a_form
    should respond_with(:success)
    should render_template(:new)
  end

  context "on GET to :edit for base folder record" do
    setup do
      @admin = Factory(:admin_user)
      @base_folder = Factory(:base_folder)
      get :edit, {:id => @base_folder.id}, {:user_id => @admin.id}
    end
    should assign_to(:base_folder)
    should respond_with(:success)
    should render_template(:edit)
    should_not set_the_flash
  end

  context "on PUT to :update an existing base folder record" do
    setup do
      @admin = Factory(:admin_user)
      @base_folder = Factory(:base_folder)
      put :update, { :id => @base_folder.id, :base_folder => {:name => 'New Status'}},
                   {:user_id => @admin.id}
    end
    should "Keep the base folder count to 1 upon update" do
      assert_equal 1, BaseFolder.count
    end
    should set_session(:user_id) { @admin.id }
    should assign_to(:base_folder)
    should set_the_flash.to( /Base folder was successfully updated./)
    should redirect_to("the base folders' list") { base_folders_path }
  end

  context "on GET to :show for an existing base folder record" do
    setup do
      @admin = Factory(:admin_user)
      @base_folder = Factory(:base_folder)
      get :show, {:id => @base_folder.id}, {:user_id => @admin.id}
    end
    should assign_to(:base_folder)
    should respond_with(:success)
    should render_template(:show)
    should_not set_the_flash
  end

  context 'on DELETE to :destroy for a base folder record' do
    setup do
      @admin = Factory(:admin_user)
      @base_folder = Factory(:base_folder)
      delete :destroy, {:id => @base_folder.id}, {:user_id => @admin.id}
    end
    should assign_to(:base_folder)
    should set_the_flash.to( /Base folder sucessfully destroyed/)
    should respond_with(:redirect)
    should redirect_to("Base folders' list") {base_folders_path }
  end

end
