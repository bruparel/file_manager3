require 'test_helper'

class FoldersControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}
  
  context "Current User" do

    setup do
      @client_user = Factory(:lead_user)
      set_current_user(@client_user)
    end

    context "on GET to :index current client with no folders" do
      setup do
        @client = Factory(:client)
        get :index, {}, {:user_id => @client_user.id, :client_id => @client.id}
      end
      should assign_to(:base_folders)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :index current client with existing folders" do
      setup do
        @folder = Factory(:folder)
        get :index, {}, {:user_id => @client_user.id,
                         :client_id => @folder.client.id, :folder_id => @folder.id}
      end
      should assign_to(:folder)
      should assign_to(:folders)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup do
        @folder = Factory(:folder)
        get :new, {}, {:user_id => @client_user.id, :client_id => @folder.client_id}
      end
      should_not set_the_flash
      should assign_to(:folder)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:new)
    end

    context "on POST to :create with valid folder data" do
      setup do
        @client = Factory(:client)
        post :create, {:folder => {:name => 'Test Folder', :eclient_flag => false}},
                      {:user_id => @client_user.id, :client_id => @client.id}
      end
      should "increment the folder count to 1 upon creation" do
        assert_equal 1, Folder.count
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) { @client.id }
      should assign_to(:folder)
      should set_the_flash.to(/Successfully created folder./)
      should redirect_to("the folder's list") { folders_path }
    end

    context "on GET to :edit for a folder record" do
      setup do
        @folder = Factory(:folder)
        get :edit, {:id => @folder.id},
                   {:user_id => @client_user.id, :client_id => @folder.client_id}
      end
      should assign_to(:folder)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
    end

    context "on PUT to :update an existing folder data" do
      setup do
        @folder = Factory(:folder)
        put :update, {:id => @folder.id, :folder => {:name => 'New Folder', :eclient_flag => false}},
                     {:user_id => @client_user.id, :client_id => @folder.client_id}
      end
      should "increment the folder count to 1 upon creation" do
        assert_equal 1, Folder.count
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) { @folder.client_id}
      should assign_to(:folder)
      should set_the_flash.to(/Successfully updated folder./)
      should redirect_to("the folder's list") { folders_path }
    end

    context 'on DELETE to :destroy for a folder record' do
      setup do
        @folder = Factory(:folder)
        delete :destroy, {:id => @folder.id}, {:user_id => @client_user.id,
                                               :client_id => @folder.client_id}
      end
      should assign_to(:folder)
      should set_the_flash.to(/Successfully deleted folder./)
      should respond_with(:redirect)
      should redirect_to("Folders' list") {folders_path }
    end

    context 'on PUT to :populate for base folders' do
      setup do
        @client = Factory(:client)
        @base_folder1 = Factory(:base_folder)
        @base_folder2 = Factory(:base_folder, :name => 'Base Folder 2')
        folder_ids_array = [@base_folder1.id, @base_folder2.id]
        put :populate, {:folder_ids => folder_ids_array},
                       {:user_id => @client_user.id, :client_id => @client.id}
      end
      should "increment the folder count to 2 upon execution" do
        assert_equal 2, Folder.count
      end
      should respond_with(:redirect)
      should redirect_to("Folders' list") {folders_path }
    end

    context "on GET to :set_current_folder" do
      setup do
        @folder = Factory(:folder)
        get :set_current_folder, {:id => @folder.id},
            {:user_id => @client_user.id, :client_id => @folder.client_id}
      end
      should "total only 1 folder" do
        assert_equal 1, Folder.count
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) {@folder.client_id}
      should set_session(:folder_id) {@folder.id}
      should set_the_flash.to(/Current folder set to/)
      should redirect_to("Documents list") {documents_path }
    end

    context "on GET to :nest" do
      setup do
        @folder = Factory(:folder)
        get :nest, {:id => @folder.id},
            {:user_id => @client_user.id, :client_id => @folder.client_id}
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) {@folder.client_id}
      should set_session(:folder_id) {@folder.id}
      should set_session(:nested_folder_id) {@folder.id}
      should redirect_to("Folders list") {folders_path }
    end

  end  

end
