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

## Get the status of message

## Cancel a programmed message

## Handle errors

If a request error occurs or the api responds with an error, Mensario throw an exception of type ```MensarioException```. Depending on the type of error, there are several exceptions that inherit from ```MensarioException```:

* ```MensarioApiException```. For errors sent by the api. Has the property ```status``` that contains the error code returned by Mensario.
