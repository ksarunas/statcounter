module RequestStubbing
  def default_credentials
    { username: 'john_brown', secret: 'johns_little_secret' }
  end
end

RSpec.configure do |config|
  config.include RequestStubbing
end
