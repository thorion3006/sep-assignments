
class Node
  attr_accessor :name
  attr_accessor :film_actor_hash
  attr_accessor :previous
  attr_accessor :movie
  attr_accessor :weight

  def initialize(name)
    @name = name
    @film_actor_hash = {}
  end
end
