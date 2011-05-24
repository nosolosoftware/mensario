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
  #
  # @param [String] task Name of api task 
  # @param [Hash] data Hash containing all data
  # @return [Hash] response hash
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

  # Load configuration and save it in @@config
  #
  # @param [Hash] opts Options
  # @option opts :config ('config/mensario.yml') Path to the configuration file
  # @option opts :profile (:default) Profile in configuration to load
  def self.config(opts = {})
    file = opts[:config] || File.expand_path('../../', __FILE__) + '/config/mensario.yml'
    config = YAML.load_file(file)
    profile = opts[:profile] || :default
    
    unless config[profile]
      raise MensarioException, "No existe el perfil en el archivo de configuración #{file}"
    end

    @@config = config[profile]
  end
    
  # Send a sms
  #
  # @param [Hash] opts Options
  # @option opts :sender Name of who send the sms
  # @option opts :text Content of sms
  # @option opts :date Ruby Time object with the send date
  # @option opts :code Country code of mobile
  # @option opts :phone Telephone number to send the sms
  #
  # All options are required
  #
  # @return [Integer] Id of sms
  def self.send_message(opts = {})
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
