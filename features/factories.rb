gem 'thoughtbot-factory_girl'
require 'factory_girl'

Factory.define :user do |u|
  u.login 'dermot'
  u.email 'dermot.brennan@gmail.com'
  u.password 'password'
  u.password_confirmation 'password'
  u.active 'active'
end

require 'features/steps/common_factory_steps'
