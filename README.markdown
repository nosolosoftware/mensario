# Mensario: a wrapper around Mensario API

This gem allows us to perform the following operations through the mensario API:

* Send sms to mobile phone (allowing instant messages and programmed messages)
* Check the status of sent messages
* Cancel a programmed message

## Config

By default, Mensario expects a YAML configuration file in ```config/mensario.yml``` root path of our application.

The YAML file expects to have the following scheme:

    :profilename:
        :license: ABCD1234
        :username: user0
        :password: pass0
    :otherprofile:
        :license: ABDC1234
        :username: user1
        :password: pass1

If the config file is located in another location we have available the method ```Mensario::config``` in order to use some different configuration. The config options are:

* :config -> Path to alternative config file
* :profile -> Profile to load
     
For example, using an alternative config file
  
    Mensario::config :config => /path/to/file.yml


## Sending a message

To send a message, we need some options:

* :sender -> Name of who send de message
* :text -> Content of message
* :code -> Country code of mobile
* :phone -> Telephone number to send de message
* :date -> Ruby Time object with the send date
* :timezone -> Timezone of the send

All options are required except ```:date``` and ```:timezone```:

* If ```:date``` is undefined the message is sent inmediately.
* If ```:timezone``` is undefined Mensario will use GMT0

If a message is sent correctly the method return its id.

An example may be something like this:

    opts = {
      :sender => 'Myself'
      :text => 'My message'
      :code => 34
      :phone => 123456789
      :timezone => 'Europe/Madrid'
    }

    Mensario::send_message opts

## Get the status of message

To check the status of a messege we need to use ```Mensario::status``` with id of message that we want to consult. All states of a message are in Mensarios API.

## Cancel a programmed message

Only messages whose state is "CMS-PEND" can be cancelled. The method ```Mensario::destroy``` cancels them.

## Handle errors

If a request error occurs or the api responds with an error, Mensario throw an exception of type ```MensarioException```. Depending on the type of error, there are several exceptions that inherit from ```MensarioException```:

* ```MensarioApiException```. For errors sent by the api. Has the property ```status``` that contains the error code returned by Mensario.
* ```MensarioHttpException```. If a problem occurs with the HTTP request.

# About
Mensario is a gem developed by [NoSoloSoftware](http://nosolosoftware.biz).

# License
Mensario is Copyright 2011 NoSoloSoftware, it is free software.

Mensario is distributed under GPLv3 license. More details can be found at COPYING file.
