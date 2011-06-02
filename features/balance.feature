Feature: Balance query

As an user that use this gem
I want to check the quantity
So that Mensario should return the balance remaining

Scenario: The query has been done correctly
  Given the license number, username and password in the profile "default"
  When I do the balance call
  Then the API should give us the balance remaining
