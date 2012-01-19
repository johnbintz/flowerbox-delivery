Given /^the server will start on the random ports? "([^"]*)"$/ do |ports|
  ports = ports.split(',').collect(&:to_i)

  @server.stubs(:random_port).returns(*ports)
end

