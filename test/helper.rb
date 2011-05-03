require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'identifiable_ipaddress'

class Test::Unit::TestCase

  def random_ipv4_address
    # FIXME exclude the 255 broadcast address
    ((1..4).map { Kernel.rand(256) }).join('.')
  end

  def local_ipv4_address
    # http://en.wikipedia.org/wiki/IP_address#IPv4_private_addresses
    (['192', '168'] + (1..2).map { Kernel.rand(256) }).join('.')
  end

end
