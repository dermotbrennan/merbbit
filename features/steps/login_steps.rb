Given /^I am not authenticated$/ do
  # yay!
end

Then /^I should be redirected to (.*)$/ do |path|
  response.should redirect_to path
end

Then /^(.+) should be rendered$/ do |template|
  response.should render_template(template) 
end
