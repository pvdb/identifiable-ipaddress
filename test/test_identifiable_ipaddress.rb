require 'helper'

class TestIdentifiableIPAddress < Test::Unit::TestCase

  context "IPAddress classes" do

    should "include the Identifiable module" do
      assert IPAddress::IPv4.included_modules.include? Identifiable
      assert IPAddress::IPv6.included_modules.include? Identifiable
    end

  end

end
