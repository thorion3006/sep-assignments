require_relative 'node'
require 'benchmark'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @head ||= node
    @head.next = node if @head.next.nil? && @head != node
    @tail.next = node if @tail
    @tail = node
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
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    node.next = @head
    @head = node
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    front = @head
    @head = front.next
    front
  end
end
