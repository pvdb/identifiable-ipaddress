require 'helper'

module TestIpaddress
  class TestIdentifiable < Test::Unit::TestCase

    context "IPAddress instances" do

      setup do
        IPAddress.reset_identities
        @ipaddress = IPAddress('127.0.0.1')
      end

      should "respond to identity?" do
        assert @ipaddress.respond_to? "identity?"
      end

      should "respond to identity" do
        assert @ipaddress.respond_to? :identity
      end

      should "respond to identity=" do
        assert @ipaddress.respond_to? "identity="
      end

    end

    context "identifiable IP addresses" do

      setup do
        IPAddress.reset_identities
        @ipaddress = IPAddress('127.0.0.1') ; @identity = 'localhost'
      end

      should "return correct identity" do
        assert !@ipaddress.identity?
        @ipaddress.identity = @identity
        assert @ipaddress.identity?
        assert_equal @identity, @ipaddress.identity
      end

    end

    context "identifiable IP subnets" do

      setup do
        IPAddress.reset_identities
        @subnet = IPAddress('127.0.0.1/24') ; @identity = 'subnet'
      end

      should "return correct identity" do
        assert @subnet.none? { |ipaddress| ipaddress.identity? }
        @subnet.identity = @identity
        assert @subnet.all? { |ipaddress| ipaddress.identity? }
        assert @subnet.all? { |ipaddress| @identity == ipaddress.identity }
      end

    end

  end # class TestIdentifiable
end # module TestIpaddress
