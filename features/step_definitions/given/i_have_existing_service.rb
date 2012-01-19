require 'thread'
require 'rack'

Given /^I have an existing service running on port "([^"]*)"$/ do |port|
  @running_server = Thread.new do
    Rack::Handler::WEBrick.run(lambda { |env| [ 200, {}, [] ] }, :Port => port) { |server|
      Thread.current[:server] = server
    }
  end

  while !@running_server[:server]
    sleep 0.1
  end
end

