Feature: License query

As an user that use this gem
I want to check the state of a license
So that Mensario should return the license status

Scenario: We consult a license that exists
  Given the license, username and password in file "auth-ok.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "OK"
  And the API should give us the type and quantity of the license

Scenario: We consult a license that doesm't exist
  Given the license, username and password in file "auth-ko_inv.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "KO-INV"

Scenario: We consult a license that exists but authentication is incorrect
  Given the license, username and password in file "auth-ko_auth.yml"
  When I do the "license_query" call
  Then the API should response with "OK" code
  And the status code should be "KO-AUTH"

Scenario: We consult some licenses
  Given the license, username and password in file "auth-ok.yml"
  And an extra license in file "auth-ko_inv.yml"
  When I do the license_query call with parameters
  Then the API should response with "OK" code
  And the response should be an Array with 2 or more fields
