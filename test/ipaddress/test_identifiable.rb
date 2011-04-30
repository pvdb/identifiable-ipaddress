require 'helper'

class TestIdentifiable < Test::Unit::TestCase

  context "IPAddress instances" do

    setup do
      @ipaddress = IPAddress('127.0.0.1')
    end

    should "respond to identifiable?" do
      assert @ipaddress.respond_to? :identifiable?
    end

    should "respond to identify" do
      assert @ipaddress.respond_to? :identify
    end

  end

  context "identifiable IPAddress instances" do

    setup do
      @ipaddress = IPAddress('127.0.0.1')
    end

    should "return correct identity" do
      assert_equal "localhost", @ipaddress.identify
    end

  end

end
