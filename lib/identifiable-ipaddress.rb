require 'rubygems'
require 'ipaddress'

require 'ipaddress/identifiable'

IPAddress::IPv4.send :include, Identifiable
IPAddress::IPv6.send :include, Identifiable
