module Identities

  def self.included(base)

    base.class_eval do
      @@ipaddress_identities = {}
    end

    class << base

      def reset_identities
        # for testing purposes only...
        @@ipaddress_identities.clear
      end

      def to_ipaddress(ipaddress)
        # to keep things DRY...
        unless ipaddress.is_a? IPAddress
          IPAddress(ipaddress)
        else
          ipaddress
        end
      end

      def identity_for? ipaddress
        !@@ipaddress_identities[to_ipaddress(ipaddress).address].nil?
      end

      def get_identity ipaddress
        @@ipaddress_identities[to_ipaddress(ipaddress).address]
      end

      def set_identity(ipaddress, identity)
        [ipaddress].flatten.each do |single_ipaddress|
          case (single_ipaddress = to_ipaddress(single_ipaddress))
          when IPAddress::IPv4
            single_ipaddress.each do |single_ipv4_address|
              @@ipaddress_identities[single_ipv4_address.address] = identity.to_s
            end
          when IPAddress::IPv6
            @@ipaddress_identities[ipaddress.address] = identity.to_s
          end
        end
      end

    end

  end

end # module Identities