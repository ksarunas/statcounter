module Statcounter
  class Configuration
    attr_accessor :username, :secret, :timeout

    def timeout
      @timeout ||= 60
    end
  end
end
