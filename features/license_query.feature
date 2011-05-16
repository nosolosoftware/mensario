Feature: License query

As an user that use this gem
I want to check the state of a license
So that Mensario should return the license status

Scenario: The query has been done correctly
  Given the license, username and password in file "auth-ok.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "OK"
  And the API should give us the type and quantity of the license

Scenario: The license number is not correct
  Given the license, username and password in file "auth-ko_inv.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "KO-INV"

Scenario: The license authentication is incorrect
  Given the license, username and password in file "auth-ko_auth.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "KO-AUTH"
