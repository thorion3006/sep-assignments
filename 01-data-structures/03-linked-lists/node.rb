class Node
  attr_accessor :prev # added to improve traverse performance in large lists.
  attr_accessor :next
  attr_accessor :data

  def initialize(data)
    @data = data
  end
end
