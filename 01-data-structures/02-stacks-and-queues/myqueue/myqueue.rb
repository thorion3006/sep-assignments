class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = []
    @head = nil
    @tail = nil
  end

  def enqueue(element)
    @queue << element
    @head ||= @queue.first
    @tail = @queue.last
  end

  def dequeue
    @queue.delete(@head)
    @head = @queue.first
    @tail = @queue.last
  end

  def empty?
    @queue.length.zero?
  end
end
