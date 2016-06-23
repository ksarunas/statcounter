$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'statcounter'
require 'timecop'
require 'rack'
require 'webmock/rspec'

WebMock.disable_net_connect!
WebMock::Config.instance.query_values_notation = :flat_array

Dir['./spec/support/**/*.rb'].each { |f| require(f) }

RSpec.configure do |config|
  config.order = :random
end
