module Identities

  def self.included(base)

    base.class_eval do
      @@ipaddress_identities = {}
    end

    class << base

      def identity_for? ipaddress
        !@@ipaddress_identities[ipaddress].nil?
      end

      def get_identity ipaddress
        @@ipaddress_identities[ipaddress]
      end

      def set_identity(ipaddress, identity)
        @@ipaddress_identities[ipaddress] = identity
      end

    end

  end

end # module Identities