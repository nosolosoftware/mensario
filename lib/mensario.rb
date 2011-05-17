require 'mensario/status'
require 'mensario/exception'
require 'xmlsimple'
require 'net/http'
require 'net/https'

module Mensario
  class Mensario
    
    # Api url to do calls
    API_HOST = 'es.servicios.mensario.com'
    API_PORT = 443
    API_PATH = '/sem/api/api.do'

    # Config data for connect to API service
    attr_accessor :license
    attr_accessor :username
    attr_accessor :password

    # Timezone for use in API
    attr_accessor :timezone
 
    # Status of the response
    attr_reader :status

    def initialize
      yield self
    end

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
    def api_call(data)
      xml = XmlSimple.xml_out(data, :rootname => 'api', :XmlDeclaration => '<?xml version="1.0" encoding="UTF-8"?>') 
      
      http = Net::HTTP.new(API_HOST, API_PORT)
      http.use_ssl =  true
      request = Net::HTTP::Post.new(API_PATH)
      request.body = xml
      response = http.request(request)
      
      result = XmlSimple.xml_in(response.body)
      @status = result['result'].first
      result
    end
    
    def synchronize
      xml = { 'task' => ['SYNC'],
              'license'  => {
                  'number' => @license,
                  'user'   => @username,
                  'pass'   => @password
              },
              'timezone' => [@timezone]
      }

      response = api_call(xml)
    end

    def send_message(prefix, phone, message)
    end

    def quantity
    end

    def license_query
    end

    def request_query(request_id)
    end
  end
end
