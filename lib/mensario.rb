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

    attr_reader :response

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
      
      @response = XmlSimple.xml_in(response.body)
      @status = @response['result'].first
      raise MensarioException.new(@status) unless @status == Status::OK
      @response
    end
    
    # Do the synchronize method of api
    #
    # @result [Integer] timestamp in the specified timezone
    def synchronize
      xml = { 'task' => ['SYNC'],
              'license'  => {
                  'number' => @license,
                  'user'   => @username,
                  'pass'   => @password
              },
              'timezone' => [@timezone]
      }

      api_call(xml)['timestamp']
    end

    def send_message(prefix, phone, message)
    end

    def quantity
      xml = { 'task' => ['QUANT-QRY'],
              'license' => {
                'number'  => @license,
                'user'    => @username,
                'pass'    => @password
              }
            }
      
      api_call(xml)['quantity'].first.to_i
    end

    def license_query
      xml = { 'task' => ['LIC-QRY'],
              'licenses' => {
                'license' => {
                  'number'  => @license,
                  'user'    => @username,
                  'pass'    => @password
                }
              }
      }

      response = api_call(xml)['licenses'].first['license'].first
      hash = { 'status' => response['status'].first }
      hash.merge!({ 'quantity' => response['quantity'].first.to_i }) if response['quantity']
      hash.merge!({ 'type' => response['type'].first }) if response['type']
      hash
    end

    def request_query(request_id)
      xml = { 'task' => ['REQU-QRY'],
              'license' => {
                'number'    => @license,
                'user'      => @username,
                'pass'      => @password
              },
              'request' => [request_id]
            }

      api_call(xml)['status']
    end
  end
end
