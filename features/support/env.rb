require 'flowerbox-delivery'

require 'mocha'

World(Mocha::API)

Before do
  mocha_setup

  FileUtils.rm_rf 'dir'
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

  FileUtils.rm_rf 'dir'
end

def temp_path_for(file)
  parts = file.split('.')[0..1].join('.')

  File.join('.tmp/sprockets', File.expand_path(parts))
end

