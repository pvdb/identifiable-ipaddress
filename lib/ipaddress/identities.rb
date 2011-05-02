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

      def identity_for? ipaddress
        !@@ipaddress_identities[ipaddress.address].nil?
      end

      def get_identity ipaddress
        @@ipaddress_identities[ipaddress.address]
      end

      def set_identity(ipaddress, identity)
        case ipaddress
        when IPAddress::IPv4
          ipaddress.each do |single_ipaddress|
            @@ipaddress_identities[single_ipaddress.address] = identity
          end
        when IPAddress::IPv6
          @@ipaddress_identities[ipaddress.address] = identity
        end
      end

    end

  end

end # module Identities