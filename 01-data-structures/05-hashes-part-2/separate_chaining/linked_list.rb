require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail
  attr_reader :size

  def initialize
    @size = 0
  end

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @head ||= node
    @head.next = node if @head.next.nil? && @head != node
    @tail.next = node if @tail
    @tail = node
    @size += 1
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head == @tail
      @head = nil
      @tail = nil
    else
      temp1 = @head
      temp2 = temp1.next
      while temp2.next
        temp1 = temp2
        temp2 = temp2.next
      end
      @tail = temp1
      @tail.next = nil
      @head.next = nil if @head == temp1
    end
    @size -= 1
  end

  # This method prints out a representation of the list.
  def print
    temp = @head
    puts temp.data
    while temp.next
      puts temp.next.data
      temp = temp.next
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    temp = @head.next
    if @head == node
      @head = temp
    elsif @tail == node
      remove_tail
    else
      prev_temp = @head
      while temp.next
        if temp == node
          prev_temp.next = temp.next
          break
        end
        prev_temp = temp
        temp = temp.next
      end
    end
    @size -= 1
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    @size += 1
    node.next = @head
    @head = node
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    front = @head
    @head = front.next
    @size -= 1
    front
  end

  def present?(value)
    temp = @head
    while temp
      return true if temp.value == value
      temp = temp.next
    end
    false
  end

  def value?(key)
    temp = @head
    while temp
      return temp.value if temp.key == key
      temp = temp.next
    end
    -1
  end
end
