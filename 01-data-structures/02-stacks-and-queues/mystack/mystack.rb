class MyStack
  attr_accessor :top

  def initialize
    @stack = []
    self.top = nil
  end

  def push(item)
    @stack[@stack.length] = item
    self.top = @stack.last
  end

  def pop
    pop = @stack.delete(top)
    self.top = @stack.last
    pop
  end

  def empty?
    @stack.length.zero?
  end
end
