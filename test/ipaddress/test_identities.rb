require 'helper'

module TestIpaddress
  class TestIdentities < Test::Unit::TestCase

    context "IPAddress class" do

      should "respond to identity_for?" do
        assert IPAddress.respond_to? :identity_for?
      end

      should "respond to get_identity" do
        assert IPAddress.respond_to? :get_identity
      end

      should "respond to set_identity" do
        assert IPAddress.respond_to? :set_identity
      end

    end

    context "IPAddress superclass" do

      should "record the identity of an IP address" do

        ipaddress = '127.0.0.1' ; identity = 'localhost'

        assert !IPAddress.identity_for?(ipaddress)
        IPAddress.set_identity(ipaddress, identity)
        assert IPAddress.identity_for?(ipaddress)
        assert_equal identity, IPAddress.get_identity(ipaddress)

      end

    end

  end # class TestIdentities
end # module TestIpaddress
