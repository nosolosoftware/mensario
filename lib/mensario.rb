require 'mensario/status'
require 'mensario/exception'

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
