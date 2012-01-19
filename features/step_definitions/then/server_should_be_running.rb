require 'net/http'

Then /^the server should have started on port "([^"]*)", interface "([^"]*)"$/ do |port, interface|
  socket = TCPSocket.new(interface, port.to_i)
  socket.close
end

