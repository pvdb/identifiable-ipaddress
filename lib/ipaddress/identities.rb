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
      
      def known_identity? identity
        @@ipaddress_identities.values.include? identity
      end

      def identity_for? ipaddress
        !get_identity(ipaddress).nil?
      end

      def get_identity ipaddress
        @@ipaddress_identities[to_ipaddress(ipaddress).address]
      end

      def set_identity(ipaddress, identity)
        [ipaddress].flatten.each do |single_ipaddress|
          case (single_ipaddress = to_ipaddress(single_ipaddress))
          when IPAddress::IPv4
            # single_ipaddress == single address or entire subnet, ie. CIDR
            single_ipaddress.each do |single_ipv4_address|
              @@ipaddress_identities[single_ipv4_address.address] = identity.to_s
            end
          when IPAddress::IPv6
            # TODO IP v6 subnets: https://github.com/bluemonk/ipaddress/pull/15
            @@ipaddress_identities[ipaddress.address] = identity.to_s
          end
        end
      end

      def set_identities(identity_hash)
        (identity_hash || {}).each_pair do |identity, ipaddress|
          set_identity(ipaddress, identity)
        end
      end
      
      def load_identities identities_file
        if identities_file && File.exists?(identities_file)
          set_identities YAML.load_file identities_file
        end
      end

    end

  end

end # module Identities