#encoding: utf-8
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
  def self.api_call(task, data = {})
    #Get config
    self::config unless @@config

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
      raise MensarioHttpException e.message
    end

    result = XmlSimple.xml_in(response.body)

    raise MensarioApiException.new(result['result'].first) unless result['result'].first == 'OK'
    return result
  end

  def self.config(opts = {})
    file = opts[:config] || File.expand_path('../../', __FILE__) + '/config/mensario.yml'
    config = YAML.load_file(file)
    profile = opts[:profile] || :default
    
    unless config[profile]
      raise MensarioException, "No existe el perfil en el archivo de configuración #{file}"
    end

    @@config = config[profile]
  end
    
  def self.send_message
  end

  def self.status(id)
  end

  # Cancel the message which receives as a parameter
  # @param [Fixnum] Message id to cancell
  # @result [TrueClass, FalseClass] Return 'true' if message is cancelled
  #   and 'false' otherwise
  def self.destroy(id)
    xml = {
      'msg' => {
        'id' => [id]
      }
    }

    self::api_call('MSG-CANC',xml)['cancelled'].nil?
  end

  # Allows to consult the balance remaining of the license
  # @result [Fixnum] the balance remaining
  def self.balance
    self::api_call('QUANT-QRY')['quantity'].first.to_i
  end
end
