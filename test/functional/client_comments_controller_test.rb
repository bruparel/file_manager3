require 'test_helper'

class ClientCommentsControllerTest < ActionController::TestCase

=begin

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "on GET to :index current client comments" do
    setup do
      @user = Factory(:user)
      @client_comment = Factory(:client_comment)
      get :index, {}, {:user_id => @user.id, :client_id => @client_comment.client.id,
                       :client_comment_id => @client_comment.id}
    end
    should_assign_to :comments
  end

=end

end
