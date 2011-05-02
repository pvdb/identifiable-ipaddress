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

      setup do
        IPAddress.reset_identities
      end

      should "record the identity of an IP v4 address" do

        ipv4_ipaddress = IPAddress('127.0.0.1') ; identity = 'localhost'

        assert ipv4_ipaddress.is_a? IPAddress::IPv4

        assert !IPAddress.identity_for?(ipv4_ipaddress)
        IPAddress.set_identity(ipv4_ipaddress, identity)
        assert IPAddress.identity_for?(ipv4_ipaddress)
        assert_equal identity, IPAddress.get_identity(ipv4_ipaddress)

      end

      should "record the identity of an IP v6 address" do

        ipv6_ipaddress = IPAddress('::1') ; identity = 'localhost'

        assert ipv6_ipaddress.is_a? IPAddress::IPv6

        assert !IPAddress.identity_for?(ipv6_ipaddress)
        IPAddress.set_identity(ipv6_ipaddress, identity)
        assert IPAddress.identity_for?(ipv6_ipaddress)
        assert_equal identity, IPAddress.get_identity(ipv6_ipaddress)

      end

      should "record the identity of IP v4 subnet" do

        subnet = IPAddress('127.0.0.1/24') ; identity = 'subnet'

        assert subnet.is_a? IPAddress::IPv4

        assert subnet.none? { |ipaddress| IPAddress.identity_for?(ipaddress) }
        IPAddress.set_identity(subnet, identity)
        assert subnet.all? { |ipaddress| IPAddress.identity_for?(ipaddress) }
        assert subnet.all? { |ipaddress| identity == IPAddress.get_identity(ipaddress) }

      end

    end

  end # class TestIdentities
end # module TestIpaddress
