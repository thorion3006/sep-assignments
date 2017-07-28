require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size)
    if @items[i].nil?
      @items[i] = LinkedList.new
      @items[i].add_to_tail(Node.new(key, value))
    elsif !@items[i].present?(value) || @items[i].value?(key) == -1
      @items[i].add_to_tail(Node.new(key, value))
    end
    resize if load_factor > @max_load_factor
    hash_state(i, value)
  end

  def [](key)
    i = index(key, size)
    @items[i].value?(key)
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.codepoints.sum % size
  end

  # Calculate the current load factor
  def load_factor
    no_of_items / size.to_f
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  def no_of_items
    sum = 0
    @items.each do |item|
      next if item.nil?
      sum += item.size
    end
    sum
  end

  # Resize the hash
  def resize
    temp = @items
    @items = Array.new(size * 2)
    temp.each do |list|
      next if list.nil?
      item = list.head
      while item
        self[item.key] = item.value
        item = item.next
      end
    end
  end

  def hash_state(index, value)
    puts "The hash item with value: #{value} is located at bucket: #{index}.\nThe current Load Factor for the hash is #{load_factor}."
  end
end
