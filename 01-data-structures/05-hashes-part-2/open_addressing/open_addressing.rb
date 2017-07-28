require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size)
    if @items[i].nil?
      @items[i] = Node.new(key, value)
      hash_state(i, value)
    elsif @items[i].value != value
      j = next_open_index(i)
      if j == -1
        resize
        self[key] = value
      else
        @items[j] = Node.new(key, value)
        hash_state(j, value)
        if @items[i].next.nil?
          @items[i].next = @items[j]
        else
          temp = @items[i].next
          while temp
            if temp.next.nil?
              temp.next = @items[j]
              break
            end
            temp = temp.next
          end
        end
      end
    end
  end

  def [](key)
    i = index(key, size)
    if @items[i] == key
      @items[i].value
    else
      temp = @items[i]
      while temp
        return temp.value if temp.key == key
        temp = temp.next
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.codepoints.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    while index < size
      return index if @items[index].nil?
      index += 1
    end
    -1
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  # Resize the hash
  def resize
    temp = Array.new(size * 2)
    @items.each do |item|
      next if item.nil?
      item.next = nil
      i = index(item.key, temp.size)
      if temp[i].nil?
        temp[i] = item
      else
        j = next_open_index(i)
        temp[j] = item unless j == -1
      end
    end
    @items = temp
  end

  def hash_state(index, value)
    lf = @items.compact.size.to_f / size.to_f
    puts "The new hash item with value: #{value} is located at index: #{index}.\nThe current Load Factor of the hash is #{lf}."
  end
end
