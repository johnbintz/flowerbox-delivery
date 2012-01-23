require 'rack'
require 'net/http'
require 'socket'

module Flowerbox
  module Delivery
    class Server
      attr_reader :options

      def initialize(options = {})
        @options = options || {}
      end

      def start
        @server_thread = Thread.new do
          Rack::Handler::WEBrick.run(lambda { |env| [ 200, {}, [] ] }, :Port => port, :Host => interface) { |server|
            Thread.current[:server] = server
          }
        end

        while !@server_thread[:server]
          sleep 0.1
        end
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

