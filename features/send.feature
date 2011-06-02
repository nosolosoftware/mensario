Feature: Send message

As a user that use this gem
I want to send a message through Mensario
So that Mensario should send the sms

Scenario: all data is ok
  Given the license number, username and password in the profile "default"
  And "NoSoloSoft" as sender
  And "texto de prueba" as text
  And 34 as prefix and "ok" phone in file "recipient.yml"
  And "Europe/Madrid" as timezone
  And a send time
  When I do the send_message call
  Then Mensario should response with a sms number

Scenario: timezone is wrong
  Given the license number, username and password in the profile "default"
  And "NoSoloSoft" as sender
  And "texto de prueba" as text
  And 34 as prefix and "ok" phone in file "recipient.yml"
  And "Europe/Cordoba" as timezone
  And a send time
  When I do the send_message call
  Then Mensario should raise a exception with status "KO-INV-TZ"

Scenario: phone is wrong
  Given the license number, username and password in the profile "default"
  And "NoSoloSoft" as sender
  And "texto de prueba" as text
  And 34 as prefix and "wrong" phone in file "recipient.yml"
  And "Europe/Madrid" as timezone
  And a send time
  When I do the send_message call
  Then Mensario should raise a exception with status "KO-INV-PHN"

Scenario: code is wrong
  Given the license number, username and password in the profile "default"
  And "NoSoloSoft" as sender
  And "texto de prueba" as text
  And 255 as prefix and "ok" phone in file "recipient.yml"
  And "Europe/Madrid" as timezone
  And a send time
  When I do the send_message call
  Then Mensario should raise a exception with status "KO-INV-CODE"
