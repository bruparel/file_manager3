require 'test_helper'
class UserTest < ActiveSupport::TestCase

  VALID_USER = {:username=>'valid_user', :email=>'valid_user@example.com', :display_name => 'Valid User',
                :password=>'123456', :password_confirmation=>'123456', :role_id => 1}

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}
  
  context 'A User instance' do
    setup do
      @user = Factory(:admin_user)
    end

    should belong_to(:role)
    should belong_to(:client)
    should have_many(:client_comments)
    should validate_presence_of(:username).with_message(/is too short/)
    should validate_presence_of(:email).with_message(/is too short/)
    should validate_presence_of(:display_name)
    should validate_presence_of(:role_id)
    should validate_uniqueness_of(:username)
    should validate_uniqueness_of(:email)
    should allow_mass_assignment_of(:username) 
    should allow_mass_assignment_of(:display_name) 
    should allow_mass_assignment_of(:email) 
    should allow_mass_assignment_of(:password) 
    should allow_mass_assignment_of(:password_confirmation) 
    should allow_mass_assignment_of(:comment) 
    should allow_mass_assignment_of(:active) 
    should allow_mass_assignment_of(:role_id) 

  end

  context 'A new User instance' do

   # should 'be valid if the password and password confirmation matches' do
   #   assert u = User.new(VALID_USER)
   #   assert u.valid?
   # end

    should 'be invalid if password confirmation does not match the password' do
      assert u = User.new(VALID_USER.merge(:password => '12345'))
      assert !u.valid?
    end

    #should 'be created when given valid options' do
    #  assert_difference "User.count" do
    #    assert u = User.create(VALID_USER)
    #    assert !u.new_record?, u.errors.full_messages.to_sentence
    #  end
    #end
  end  

end
