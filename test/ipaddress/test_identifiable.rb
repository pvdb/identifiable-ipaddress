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

    context "identifiable IP v4 addresses" do

      setup do
        IPAddress.reset_identities
        @ipv4_address = IPAddress('127.0.0.1') ; @identity = 'localhost'
      end

      should "return correct identity" do
        assert !@ipv4_address.identity?
        @ipv4_address.identity = @identity
        assert @ipv4_address.identity?
        assert_equal @identity, @ipv4_address.identity
      end
      
      should "respond to identity enquiry methods" do
        assert !@ipv4_address.respond_to?(:localhost?)
        assert !@ipv4_address.respond_to?(:remote_host?)
        
        @ipv4_address.identity = @identity
        
        assert @ipv4_address.send(:localhost?)
        assert !@ipv4_address.respond_to?(:remote_host?)
      end

    end

    context "identifiable IP v6 addresses" do

      setup do
        IPAddress.reset_identities
        @ipv6_address = IPAddress('::1') ; @identity = 'localhost'
      end

      should "return correct identity" do
        assert !@ipv6_address.identity?
        @ipv6_address.identity = @identity
        assert @ipv6_address.identity?
        assert_equal @identity, @ipv6_address.identity
      end
      
      should "respond to identity enquiry methods" do
        assert !@ipv6_address.respond_to?(:localhost?)
        assert !@ipv6_address.respond_to?(:remote_host?)
        
        @ipv6_address.identity = @identity
        
        assert @ipv6_address.send(:localhost?)
        assert !@ipv6_address.respond_to?(:remote_host?)
      end

    end

    context "identifiable IP v4 subnets" do

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
