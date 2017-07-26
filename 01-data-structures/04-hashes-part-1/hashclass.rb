require_relative 'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size)
    if @items[i].nil?
      @items[i] = HashItem.new(key, value)
    elsif @items[i].value != value
      resize
      @items[index(key, size)] = HashItem.new(key, value)
    end
    puts "Hash size after insertion: #{size}.\n#{@items}"
  end


  def [](key)
    @items[index(key, size)].value
  end

  def resize
    temp = Array.new(size*2)
    @items.each do |item|
      temp[index(item.key, temp.size)] = item unless item.nil?
    end
    @items = temp
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    (key.codepoints.sum * Math::PI / 2.718281828459045 - 1.414213562373095).round % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

end
