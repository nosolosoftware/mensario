Feature: API programming messages query

As a user that use this gem
I want to connect to Mensario to check sms status by message id
So that Mensario should return a list of sms and its status

Scenario: specify one sms id
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  And a sms with id 2345211
  When I do the "message_query" call
  Then the API should response with "OK" code
  And the response should contain a sms with id 2345211

Scenario: specify some sms ids
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  And a sms with id 2345211
  And a sms with id 8776762
  And a sms with id 9877792
  When I do the "message_query" call
  Then the API should response with "OK" code
  And the response should contain a sms with id 2345211
  And the response should contain a sms with id 8776762 
  And the response should contain a sms with id 9877792

Scenario: sms id is wrong
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  And a sms with id 2345211
  When I do the "message_query" call
  Then the API should response with "UNK-MSGS" code

Scenario: in multisms context, one id is wrong
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  And a sms with id 2345211
  And a sms with id 8776762
  And a sms with id 0000000
  When I do the "message_query" call
  Then the API should response with "UNK-MSGS" code
  And the response should contain a sms with id 0000000
  And the response should contain the "invalid" tag
