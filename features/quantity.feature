Feature: Quantity query

As an user that use this gem
I want to check the quantity
So that Mensario should return the quantity remaining

Scenario: The query has been done correctly
  Given the license, username and password in file "auth-ok.yml"
  When I do the "quantity" call
  Then the API should response with "OK" code
  And the API should give us the quantity remaining
