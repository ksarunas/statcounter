require 'statcounter/version'
require 'statcounter/client'
require 'statcounter/configuration'
require 'statcounter/errors'
require 'statcounter/params_encoder'
require 'statcounter/projects'

module Statcounter
  API_URL = 'http://api.statcounter.com/'.freeze

  module_function

  def configure
    yield(config)
  end

  def config
    @config ||= Configuration.new
  end

  def client
    @client ||= Client.new
  end

  def default_credentials
    @default_credentials ||= { username: config.username, secret: config.secret }
  end
end
