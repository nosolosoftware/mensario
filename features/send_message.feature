Feature: Send message

As an user than use this gem
I want to send a message
So that Mensario should return the state of the message

Scenario: The message has been sent correctly
  Given the license, username and password in file "auth-ok.yml"
  And the phone number in the file "recipient-ok.yml"
  And the prefix "34"
  And the text body
  When I do the send_message call
  Then the API should response with "OK" code
  And the API should give us the request id

Scenario: The recipient number is not correct
  Given the license, username and password in file "auth-ok.yml"
  And the phone number in the file "recipient-ko.yml"
  And the prefix "34"
  And the text body
  When I do the send_message call
  Then the API should response with "KO-INV-PHON" code

Scenario: The prefix is not correct
  Given the license, username and password in file "auth-ok.yml"
  And the phone number in the file "recipient-ok.yml"
  And the prefix "100"
  And the text body
  When I do the send_message call
  Then the API should response with "KO-INV-CODE" code
