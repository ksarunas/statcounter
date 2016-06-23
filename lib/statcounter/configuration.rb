module Statcounter
  class Configuration
    attr_accessor :username, :secret, :timeout, :timezone

    def timeout
      @timeout ||= 60
    end

    def timezone
      @timezone ||= 'America/New_York'
    end
  end
end
