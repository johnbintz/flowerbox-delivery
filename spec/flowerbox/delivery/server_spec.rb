require 'spec_helper'
require 'socket'
require 'thread'

describe Flowerbox::Delivery::Server do
  let(:server) { described_class.new(options) }
  let(:options) { nil }

  subject { server }

  describe '#initialize' do
    let(:options) { { :port => port, :interface => interface } }
    let(:port) { 'port' }
    let(:interface) { 'interface' }

    its(:port) { should == port }
    its(:interface) { should == interface }
  end

  describe '#start' do
    let(:port) { 12345 }
    let(:interface) { '127.0.0.1' }

    before do
      server.stubs(:port).returns(port)
      server.stubs(:interface).returns(interface)
    end

    it 'should start a Rack server' do
      server.start

      TCPSocket.new(server.interface, server.port)
    end
  end

  describe '#interface' do
    subject { server.interface }

    it { should == '0.0.0.0' }
  end

  describe '#port' do
    let(:interface) { '127.0.0.1' }

    before do
      server.stubs(:interface).returns(interface)
    end

    subject { server.port }

    context 'no running service' do
      before do
        Kernel.stubs(:rand).returns(0)
      end

      it { should == 25000 }
    end

    context 'running service' do
      before do
        @server = Thread.new do
          TCPServer.new(interface, 25000)
        end

        server.stubs(:random_port).returns(25000, 25001)
      end

      it { should == 25001 }
    end
  end
end

