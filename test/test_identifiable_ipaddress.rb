require 'helper'

class TestIdentifiableIPAddress < Test::Unit::TestCase

  context "IPAddress superclass" do

    should "include the Identities module" do
      assert IPAddress.included_modules.include? Identities
      assert IPAddress.class_variable_defined? :@@ipaddress_identities
    end

  end

  context "IPAddress subclasses" do

    should "include the Identifiable module" do
      assert IPAddress::IPv4.included_modules.include? Identifiable
      assert IPAddress::IPv6.included_modules.include? Identifiable
    end

  end

end
