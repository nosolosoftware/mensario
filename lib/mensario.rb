#encoding: utf-8

# Copyright 2011 NoSoloSoftware

# This file is part of Mensario.
# 
# Mensario is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Mensario is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Mensario.  If not, see <http://www.gnu.org/licenses/>.

require 'yaml'
require 'mensario/exception'
require 'xmlsimple'
require 'net/http'
require 'net/https'
require 'uri'

# A class that allow us to send a sms message through Mensario SMS Service
class Mensario
  # Api host
  API_HOST = 'es.servicios.mensario.com'
  
  # Api port
  API_PORT = 443
  
  #Api path
  API_PATH = '/sem/api/api.do'

  # Store config
  @@config = {}

  # Set the value of the license number
  #
  # @param [String] license License number
  def self.license=(license)
    @@config[:license] = license
  end

  # Set the value of the username of license
  #
  # @param [String] username Username
  def self.username=(username)
    @@config[:username] = username
  end

  # Set the value of the password of license
  #
  # @param [String] password Password
  def self.password=(password)
    @@config[:password] = password
  end

  # Set configuration parameters license, username and password 
  # through a block
  # 
  # @example
  #   Mensario::set_config do |m|
  #     m.license = "ASDER1234512"
  #     m.username = "caee4444"
  #     m.password = "xcderfa23"
  #   end
  def self.set_config
    yield self
  end


  # Do de api call with all data and process the response
  #
  # @param [String] task Name of api task 
  # @param [Hash] data Hash containing all data
  # @return [Hash] response hash
  def self.api_call(task, data = {})
    #Get config
    self::config unless @@config[:license] && @@config[:username] && @@config[:password]

    basic = { 'task' => ["#{task}"],
              'license' => {
                'number' =>@@config[:license],
                'user'   =>@@config[:username],
                'pass'   =>@@config[:password]
              }
    }

    xml = XmlSimple.xml_out(basic.merge(data), :rootname => 'api', :XmlDeclaration => '<?xml version="1.0" encoding="UTF-8"?>') 

    begin
      http = Net::HTTP.new(API_HOST, API_PORT)
      http.use_ssl =  true
      request = Net::HTTP::Post.new(API_PATH)
      request.body = xml
      response = http.request(request)
    rescue Exception => e
      raise MensarioHttpException.new e.message
    end

    result = XmlSimple.xml_in(response.body)

    raise MensarioApiException.new(result['result'].first), result['result'].first unless result['result'].first == 'OK'
    return result
  end

  # Load configuration and save it in @@config
  #
  # @param [Hash] opts Options
  # @option opts :config ('config/mensario.yml') Path to the configuration file
  # @option opts :profile (:default) Profile in configuration to load
  def self.config(opts = {})
    file = opts[:config] || Dir.getwd + '/config/mensario.yml'
    config = YAML.load_file(file)
    profile = opts[:profile] || :default
    
    unless config[profile]
      raise MensarioException.new "Profile doesn't exist in configuration file #{file}"
    end

    @@config = config[profile]
  end
    
  # Send a sms
  #
  # @param [Hash] opts Options
  # @option opts :sender Name of who send the sms
  # @option opts :text Content of sms
  # @option opts :date ('now') Ruby Time object with the send date.
  #   Message is sent inmediately if :date is undefined
  # @option opts :code Country code of mobile
  # @option opts :phone Telephone number to send the sms
  # @option opts :timezone ('') Timezone of the send.
  #
  # All options are required except :date and :timezone
  #
  # @return [Integer] Id of sms
  def self.send_message(opts = {})
    date = opts[:date] || '00000000000000'
    date = date.strftime('%Y%m%d%H%M%S') if date.class == Time

    xml = {
      'timezone' => [ opts[:timezone] || '' ],
      'msg' => {
        'sender' => [ opts[:sender] ],
        'text' => [ URI.encode(opts[:text]) ],
        'date' => [ date ],
        'rcp' => {
          'cod' => opts[:code],
          'phn' => opts[:phone]
        }
      }
    }

    self::api_call('SEND', xml)['msg'].first['id'].first.to_i
  end

  # Get the status of a sms
  #
  # @param [Integer] id Id of the sms
  # @return [String] status code
  def self.status(id)
    xml = { 'msg' => {
              'id' => ["#{id}"]
            }
    }

    self::api_call('MSG-QRY', xml)['status'].first['cod']
  end

  # Cancel the message which receives as a parameter
  # @param [Integer] Message id to cancell
  # @return [Boolean] Return 'true' if message is cancelled
  #   and 'false' if the message can't be cancelled
  def self.destroy(id)
    xml = {
      'msg' => {
        'id' => [id]
      }
    }

    self::api_call('MSG-CANC',xml)['cancel'].first.to_i == 1
  end

  # Allows to consult the balance remaining of the license
  # @return [Integer] the balance remaining
  def self.balance
    self::api_call('QUANT-QRY')['quantity'].first.to_i
  end
end
