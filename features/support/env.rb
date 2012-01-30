require 'flowerbox-delivery'

require 'mocha'
require 'fakefs/safe'

World(Mocha::API)

class FakeFS::File::Stat
  def file?
    File.file?(@file)
  end
end

class FakeFS::File
  def self.executable?(file)
    false
  end
end

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

def temp_path_for(file)
  File.join('.tmp/sprockets', File.expand_path(file.gsub(%r{\.js.*$}, '.js')))
end

Before('@fakefs') do
  FakeFS.activate!
end

After('@fakefs') do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!
end

Before('@realfs') do
  FileUtils.rm_rf 'dir'
end

After('@realfs') do
  FileUtils.rm_rf 'dir'
end
