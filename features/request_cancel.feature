Feature: API petition cancel

As a user that use this gem
I want to connect to Mensario in order to cancel a petition
So that Mensario should return a list of cancelled sms

Scenario: using a valid petition id
  Given the license, username and password in file "auth-ok.yml"
  And a "Europe/Madrid" timezone
  And a new petition with 2 sms
  When I do the "request_cancel" call
  Then the API should response with "OK" code
  And the response should contain the "refunded-quantity" tag
  And the response should contain the "total" tag
  And the response should contain the "cancel" tag
Scenario: using a invalid petition id

Scenario: using a valid petition id but any sms can be canceled
