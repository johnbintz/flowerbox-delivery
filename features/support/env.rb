require 'flowerbox-delivery'

require 'mocha'
require 'fakefs/safe'

World(Mocha::API)

class FakeFS::File::Stat
  def file?
    File.file?(@file)
  end
end

Before do
  mocha_setup

  FakeFS.activate!
end

After do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end

  FakeFS.deactivate!

  if @running_server
    @running_server[:server].shutdown
    @running_server = nil

    sleep 0.1
  end

  @server.stop if @server
end
