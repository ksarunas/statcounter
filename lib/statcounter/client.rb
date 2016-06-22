require 'faraday'
require 'faraday_middleware'

module Statcounter
  class Client
    STATUS_FAIL = 'fail'.freeze

    def get(path, params: {}, credentials: nil)
      response = connection(credentials).get(path, params)
      body = JSON.parse(response.body, symbolize_names: true)

      if body[:@attributes][:status] == STATUS_FAIL
        raise Error, body[:error][0][:description]
      end

      body
    rescue Faraday::ClientError => e
      raise Error, 'Server could not process your request'
    end

    private

    def connection(credentials)
      @connection ||= build_connection(credentials)
    end

    def build_connection(credentials)
      Faraday.new(url: Statcounter::API_URL) do |c|
        c.adapter Faraday.default_adapter
        c.use FaradayMiddleware::FollowRedirects, limit: 3
        c.response :json, content_type: /\bjson$/
        c.response :raise_error
        c.options[:timeout] = config.timeout
        c.options[:open_timeout] = config.timeout
        c.options[:params_encoder] = Statcounter::ParamsEncoder.new(credentials)
      end
    end

    def config
      Statcounter.config
    end
  end
end
