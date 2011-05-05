require 'helper'

module TestIplookup
  class TestApplication < Test::Unit::TestCase

    context "IPLookup application" do

      should "convert a non-identifiable IP address to itself" do
        ipv4_address = random_ipv4_address

        stdin = StringIO.new(ipv4_address, "r")
        stdout = StringIO.new
        IPLookup::Application.new.run!(stdin, stdout)
        stdout.rewind

        assert_equal ipv4_address, stdout.read.chomp
      end


      should "convert a single identifiable IP address to its identity" do
        ipv4_address = random_ipv4_address

        IPAddress.set_identity(ipv4_address, 'blegga')

        stdin = StringIO.new(ipv4_address, "r")
        stdout = StringIO.new
        IPLookup::Application.new.run!(stdin, stdout)
        stdout.rewind

        assert_equal 'blegga', stdout.read.chomp
      end

    end

  end # class TestApplication
end # module TestIplookup
