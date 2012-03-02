require 'rack'
require 'net/http'
require 'socket'

module Flowerbox
  module Delivery
    class Server
      attr_reader :options

      def initialize(options = {})
        @options = { :logging => false }.merge(options || {})
      end

      def start
        @server_thread = Thread.new do
          server_options = { :Port => port, :Host => interface }
          if !options[:logging]
            server_options[:AccessLog] = [ nil, nil ]
            server_options[:Logger] = Logger.new('/dev/null')
          end

          ::Rack::Handler::WEBrick.run(options[:app], server_options) do |server|
            trap('QUIT') { server.stop }

            Thread.current[:server] = server
          end
        end

        while !@server_thread[:server] && @server_thread.alive?
          sleep 0.1
        end

        raise StandardError.new("Server died") if !@server_thread.alive?
      end

      def stop
        if @server_thread
          @server_thread[:server].shutdown

          wait_for_server_to_stop
        end
      end

      def interface
        options[:interface] || '0.0.0.0'
      end

      def port
        return @port if @port ||= options[:port]

        attempts = 20

        begin
          attempts -= 1

          current_port = random_port

          begin
            socket = TCPSocket.new(interface, current_port)
            socket.close
          rescue Errno::ECONNREFUSED => e
            @port = current_port
          end
        end while !@port and attempts > 0

        raise StandardError.new("can't start server") if attempts == 0

        @port
      end

      private
      def wait_for_server_to_start
        while true do
          begin
            connect_interface = '127.0.0.1' if interface == '0.0.0.0'

            TCPSocket.new(connect_interface, port)
            break
          rescue Errno::ECONNREFUSED => e
          end

          sleep 0.1
        end
      end

      def wait_for_server_to_stop
        while true do
          begin
            connect_interface = '127.0.0.1' if interface == '0.0.0.0'

            socket = TCPSocket.new(connect_interface, port)
            socket.close
          rescue Errno::ECONNREFUSED => e
            return
          end

          sleep 0.1
        end
      end

      def random_port
        25000 + Kernel.rand(1000)
      end
    end
  end
end

