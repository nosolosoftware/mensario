Feature: Request query

As an user that use this gem
I want to check the state of a request
So that Mensario should return the status code

Scenario: The query has been done correctly
  Given the license, username and password in file "auth-ok.yml"
  And the request id
  When I do the request_query call
  Then the API should response with "OK" code
  And the API should give us the status code of the request

Scenario: The request id is not correct
  Given the license, username and password in file "auth-ok.yml"
  And a wrong request id
  When I do the request_query call
  Then the API should response with "KO-UNK-REQU" code
  
