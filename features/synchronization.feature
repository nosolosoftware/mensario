Feature: API synchronization

As a user that use this gem
I want to connect to Mensario for synchronize
So that Mensario should return its time

Scenario: authentication error
  Given the license, username and password in file "auth-ko.yml"
  When I do the synchronization petition
  Then the API should response with "KO-INV-AUTH" code

Scenario: timezone not specified
  Given the license, username and password in file "auth-ok.yml"
  And a empty timezone
  When I do the synchronization petition
  Then the API should response with "OK" code
  And the timestamp should be in "GTM+0"

Scenario: timezone not valid
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Cordoba" timezone
  When I do the synchronization petition
  Then the API should response with "KO-INV-TZ" code

Scenario: all parts of petition are correct
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  When I do the synchronization petition
  Then the API should response with "OK" code
  And the timestamp should be in "GMT+2"
