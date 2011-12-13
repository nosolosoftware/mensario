Feature: Destroy request

As an user that use this gem
I want to cancel a sent message
So that Mensario should return if the message is cancelled

Scenario: The message can be cancelled
  Given the license number, username and password in the profile "default"
  And a new message id
  When I do the destroy call
  Then the API should tell us that the message is cancelled

Scenario: The message can't be cancelled
  Given the license number, username and password in the profile "default"
  And the id "46839223"
  When I do the destroy call
  Then the API should tell us that the message can't be cancelled

Scenario: The message id is incorrect
  Given the license number, username and password in the profile "default"
  And the id "4"
  When I do the destroy call
  Then Mensario should raise a exception with status "KO-UNK-MSGS"
  And the message of the exception should be "KO-UNK-MSGS"
