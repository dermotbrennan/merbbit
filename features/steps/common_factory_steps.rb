Given /^a user with login "(.+)", email "(.+)" and password "(.+)"$/ do |login, email, password|
  Factory(:user, :login => login, :email => email, :password => password, :password_confirmation => password)
end