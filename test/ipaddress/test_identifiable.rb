require 'helper'

module TestIpaddress
  class TestIdentifiable < Test::Unit::TestCase

    context "IPAddress instances" do

      setup do
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

    context "identifiable IPAddress instances" do

      setup do
        @ipaddress = IPAddress('127.0.0.1')
      end

      should "return correct identity" do
        assert !@ipaddress.identity?
        @ipaddress.identity = 'localhost'
        assert_equal 'localhost', @ipaddress.identity
        assert @ipaddress.identity?
      end

    end

  end # class TestIdentifiable
end # module TestIpaddress
