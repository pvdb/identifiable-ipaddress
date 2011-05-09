require 'helper'

module TestIplookup
  class TestApplication < Test::Unit::TestCase

    context "IPLookup application options" do

      should "set rc config file if it exists" do
        tempfile = Tempfile.new(File.join("foo_bar.yml")).path
        assert File.exists? tempfile
        application = IPLookup::Application.new(['-r', tempfile])
        assert_equal tempfile, application.options.rc_file
      end

      should "not set rc config file if it doesn't exists" do
        tempfile = File.join(Dir::tmpdir, "foo_bar.yml")
        assert !File.exists?(tempfile)
        application = IPLookup::Application.new(['-r', tempfile])
        assert_equal nil, application.options.rc_file
      end

    end

    context "IPLookup application" do

      should "convert a non-identifiable IP address to itself" do
        ipv4_address = random_ipv4_address

        # don't set an identity for that IP address
        assert_nil IPAddress(ipv4_address).identity

        stdin = StringIO.new(ipv4_address, "r")
        stdout = StringIO.new

        IPLookup::Application.new.run!(stdin, stdout)

        stdout.rewind
        assert_equal ipv4_address, stdout.read.chomp
      end


      should "convert a single identifiable IP address to its identity" do
        ipv4_address = random_ipv4_address

        IPAddress.set_identity(ipv4_address, 'blegga')
        assert_not_nil IPAddress(ipv4_address).identity

        stdin = StringIO.new(ipv4_address, "r")
        stdout = StringIO.new

        IPLookup::Application.new.run!(stdin, stdout)

        stdout.rewind
        assert_equal 'blegga', stdout.read.chomp
      end

      should "convert identifiable IP addresses to their identity" do
        first_ipv4_address = random_ipv4_address
        second_ipv4_address = random_ipv4_address

        identities_yaml_file = begin
          tempfile = Tempfile.new('identities.yml')
          tempfile.write({
            "first" =>  first_ipv4_address,
            "second" => second_ipv4_address,
          }.to_yaml)
          tempfile.flush
          tempfile.close
          tempfile
        end

        (application = IPLookup::Application.new(['-r', identities_yaml_file.path])).run!(StringIO.new(""))
        assert_equal identities_yaml_file.path, application.options.rc_file

        assert_equal "first", IPAddress.get_identity(first_ipv4_address)
        assert_equal "second", IPAddress.get_identity(second_ipv4_address)
      end

    end

  end # class TestApplication
end # module TestIplookup
