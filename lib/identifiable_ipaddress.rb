require 'yaml'
require 'tempfile'

require 'rubygems'
require 'ipaddress'

require 'ipaddress/identities'
require 'ipaddress/identifiable'

IPAddress.send :include, Identities

IPAddress::IPv4.send :include, Identifiable
IPAddress::IPv6.send :include, Identifiable
