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

      def identifying_ipaddress_for address
        address = to_ipaddress(address) # normalize the lookup key
        @@ipaddress_identities.keys.find { |ipaddress| ipaddress.include? address }
      end

      def get_identity ipaddress
        @@ipaddress_identities[identifying_ipaddress_for(ipaddress)]
      end

      def set_identity(ipaddress, identity)
        [ipaddress].flatten.each do |single_ipaddress|
          single_ipaddress = to_ipaddress(single_ipaddress) # normalize the identity key
          @@ipaddress_identities[single_ipaddress] = identity.to_s
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