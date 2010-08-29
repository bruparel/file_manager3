require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  context "on GET to :instruct" do
    setup do
      Role.create(:name => 'eclient', :display_name => 'External Client')
      @admin = Factory(:admin_user)
      get :instruct, {}, {:user_id => @admin.id}
    end
    should assign_to(:controller_name)
    should_not assign_to(:klass)
    should respond_with(:success)
    should render_template(:instruct)
  end

end
