module Mensario
  class MensarioException < Exception
    
    # Response code from API
    attr_reader :status

    # Initialize the mensario exception class
    #
    # @param status response code from API
    def initialize(status)
      @status = status
    end

  end
end
