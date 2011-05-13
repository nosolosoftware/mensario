class Mensario
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
end
