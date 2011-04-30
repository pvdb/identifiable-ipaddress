require 'helper'

class TestIdentities < Test::Unit::TestCase

  context "IPAddress class" do

    should "respond to identifiable?" do
      assert IPAddress.respond_to? :identifiable?
    end

    should "respond to identify" do
      assert IPAddress.respond_to? :identify
    end

  end

end
