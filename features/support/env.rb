require 'flowerbox-delivery'

require 'mocha'

World(Mocha::API)

Before do
  mocha_setup
end

After do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end

  if @running_server
    @running_server[:server].shutdown
    @running_server = nil

    sleep 0.1
  end

  @server.stop if @server
end
