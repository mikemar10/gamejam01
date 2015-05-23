require 'securerandom'

class Component < Struct
  # Ugly hack necessary to be able to build an "empty" struct with nothing
  # but an ID. Allows for construction of a struct without passing args
  def self.new(*args)
    super(*args << :id)
  end

  def initialize(*)
    super
    self.id = SecureRandom.uuid
  end
end
