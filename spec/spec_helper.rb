$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'statcounter'
require 'timecop'
require 'rack'

RSpec.configure do |config|
  config.order = :random
end
