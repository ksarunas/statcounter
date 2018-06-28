require 'faraday'
require 'faraday_middleware'

module Statcounter
  class Client
    STATUS_FAIL = 'fail'.freeze

    def get(path, params: {}, credentials: nil)
      response = connections[credentials].get(path, params)
      body = JSON.parse(response.body, symbolize_names: true)

      if body[:@attributes][:status] == STATUS_FAIL
        raise Error, body[:error][0][:description]
      end

      body
    rescue Faraday::ClientError
      raise Error, 'Server could not process your request'
    end

    private

    def connections
      @connections ||= Hash.new do |connections, credentials|
        connections[credentials] = build_connection(credentials)
      end
    end

    def build_connection(credentials)
      Faraday.new(url: Statcounter::API_URL) do |c|
        c.use FaradayMiddleware::FollowRedirects, limit: 3
        c.response :json, content_type: /\bjson$/
        c.response :raise_error
        c.options[:timeout] = config.timeout
        c.options[:open_timeout] = config.timeout
        c.options[:params_encoder] = Statcounter::ParamsEncoder.new(credentials)
        c.adapter Faraday.default_adapter
      end
    end

    def config
      Statcounter.config
    end
  end
end
