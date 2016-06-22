require 'faraday'
require 'faraday_middleware'

module Statcounter
  class Client
    def get(path, params = {}, credentials = nil)
      response = connection(credentials).get(path, params)
      response.body
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
