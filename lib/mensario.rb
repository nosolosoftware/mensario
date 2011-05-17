require 'mensario/status'
require 'mensario/exception'
require 'xmlsimple'

module Mensario
  class Mensario
    # Config data for connect to API service
    attr_accessor :license
    attr_accessor :username
    attr_accessor :password

    # Timezone for use in API
    attr_accessor :timezone
 
    def initialize
      yield self
    end

    # Create the request xml for api call with basic options
    #
    # @param [String] task name of the api task
    # @param [Hash] options a hash containing the other data to add in api call using the xmlsimple format
    # @return [String] xml formatted ready for api call
    def create_xml(task, options = {})
      #default xml structure
      xml = { 'task' => ["#{task}"],
              'license' => {
                'number' => @license,
                'user'   => @username,
                'pass'   => @password
              }
      }

      xml = xml.merge options

      XmlSimple.xml_out(xml, :rootname => 'api', :XmlDeclaration => '<?xml version="1.0" encoding="UTF-8"?>')
    end
    
    def synchronize
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
