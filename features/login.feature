Feature: Login
  To ensure the safety of the application
  A regular user of the system
  Must authenticate before using the app

  Scenario: Failed Login
    Given I am not authenticated
    When I go to /login
    And I fill in "email" with "i_dont_exist"
    And I fill in "password" with "and_i_dont_have_a_password"
    And I press "Log In"
    Then the login request should fail
    Then I should see an error message
    
  Scenario: Successful Login
    Given I am not authenticated
    And a user with login "me", email "me@example.com" and password "secret_password"
    When I go to /login
    And I fill in "email" with "me@example.com"
    And I fill in "password" with "secret_password"
    And I press "Log In"
    Then the login request should succeed
    And I should see "me" in user_login