require 'statcounter/version'

module Statcounter
  module_function

  def configure
    yield(config)
  end

  def config
    @config ||= Configuration.new
  end
end
