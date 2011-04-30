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

end # module Identifiable