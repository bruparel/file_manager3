Given /^I am signed up as "(.*)\/(.*)"$/ do |user_name, password|
  user = Factory :lead_user,
    :username                 => user_name,
    :password                 => password,
    :password_confirmation    => password
end

When /^I log in as "(.*)\/(.*)"$/ do |user_name,password|
  visit login_url
  fill_in "Username", :with => user_name
  fill_in "Password", :with => password
  click_button "Log in"
end

Then /^I should be logged in$/ do
  response.should contain("Logged in successfully.")
end

When /^I log out$/ do
  visit logout_url
end
