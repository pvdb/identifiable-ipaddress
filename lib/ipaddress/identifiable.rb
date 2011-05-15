module Identifiable

  def identity?
    IPAddress.identity_for? self
  end

  def identity
    IPAddress.get_identity self
  end

  def identity= identity
    IPAddress.set_identity self, identity
  end
  
  def respond_to?(symbol, include_private = false)
    (symbol.to_s[-1,1] == "?" && IPAddress.known_identity?(symbol.to_s[0..-2])) || super
  end
  
  def method_missing(symbol, *args)
    # modeled after ActiveSupport::StringInquirer
    if symbol.to_s[-1,1] == "?" && IPAddress.known_identity?(symbol.to_s[0..-2])
      self.identity == symbol.to_s[0..-2]
    else
      super
    end
  end

end # module Identifiable