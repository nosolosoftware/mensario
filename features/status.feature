Feature: Status query

As an user that use this gem
I want to check the status of a sent message
So that Mensario should return status code

Scenario: The message id is correct
  Given the license number, username and password in the profile "default"
  And the id "46189571"
  When I do the status call
  Then the API should give us the status code "CMS-PEND"

Scenario: The message id is incorrect
  Given the license number, username and password in the profile "default"
  And the id "4"
  When I do the status call
  Then Mensario should raise a exception with status "KO-UNK-MSGS"
