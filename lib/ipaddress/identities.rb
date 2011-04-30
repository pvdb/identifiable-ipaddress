module Identities

  def self.included(base)

    base.class_eval do
      @@ipaddress_identities = {}
    end

    class << base

      def identifiable?
        return false
      end

      def identify
        return nil
      end

    end

  end

end # module Identities