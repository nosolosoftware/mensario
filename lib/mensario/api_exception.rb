# Exception for raise errors from api
class MensarioApiException < MensarioException
  # Response code from API
  attr_reader :status

  # Initialize the mensario exception class
  #
  # @param status response code from API
  def initialize(status)
    @status = status
  end
end
