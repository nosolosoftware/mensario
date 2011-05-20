require 'mensario/exception'
require 'xmlsimple'
require 'net/http'
require 'net/https'

class Mensario
  # Api url to do calls
  API_HOST = 'es.servicios.mensario.com'
  API_PORT = 443
  API_PATH = '/sem/api/api.do'

  # Store config
  @@config

  # Do de api call with all data and process the response
  # @param [Hash] data hash containing all data
  # @result [Hash] response hash
  # @example xml
  #   xml = { 'task' => ['SYNC'],
  #           'license' => {
  #             'number' => @license,
  #             'user'   => @username,
  #             'pass'   => @password
  #           }
  #   }
  def self.api_call(data)
    xml = XmlSimple.xml_out(data, :rootname => 'api', :XmlDeclaration => '<?xml version="1.0" encoding="UTF-8"?>') 
      
    http = Net::HTTP.new(API_HOST, API_PORT)
    http.use_ssl =  true
    request = Net::HTTP::Post.new(API_PATH)
    request.body = xml
    response = http.request(request)
      
    @response = XmlSimple.xml_in(response.body)
    @status = @response['result'].first
  end

  def self.config(profile)
  end
    
  def self.send
  end

  def self.status(id)
  end

  def self.destroy(id)
  end

  # Allows to consult the quantity remaining
  # @result [Fixnum] the quantity remaining of the license
  def self.balance
    xml = { 'task' => ['QUANT-QRY'],
            'license' => {
              'number'  => @license,
              'user'    => @username,
              'pass'    => @password
            }
          }
      
    api_call(xml)['quantity'].first.to_i
  end
end
