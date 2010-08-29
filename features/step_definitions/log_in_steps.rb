Given /^No user exists with a user name and password credentials of "(.*)\/(.*)"$/ do |user_name,password|
  assert_nil User.find_by_username(user_name)
end

Given /^A user exists with a user name and password credentials of "(.*)\/(.*)"$/ do |user_name,password|
  Factory.create(:lead_user,:username => user_name,:password => password,:password_confirmation => password)
end


When /^I try to sign in with a user name and password credentials of "(.*)\/(.*)"$/ do |user_name,password|
  visit login_url
  fill_in "Username", :with => user_name
  fill_in "Password", :with => password
  click_button "Log in"
end

