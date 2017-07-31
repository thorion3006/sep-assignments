require_relative 'node'

class BinaryHeap

  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def insert(node)
    queue = [@root]
    while queue.any?
      root = queue.shift
      if root.left.nil?
        root.left = node
        node.parent = root
        queue.clear
      elsif root.right.nil?
        root.right = node
        node.parent = root
        queue.clear
      else
        queue.push(root.left)
        queue.push(root.right)
      end
    end
    swap(node) while node != @root && node.rating < node.parent.rating
  end

  def swap(node)
    parent = node.parent
    grandparent = parent.parent
    right = node.right
    left = node.left
    node == parent.right ? neighbor = parent.left : neighbor = parent.right
    if parent.right.nil? || (parent.right != node && (parent.right != node.right || parent.right != node.left))
      node.right = parent.right
    else
      node.right = parent
    end
    parent.right = right
    if parent.left.nil? || (parent.left != node && (parent.left != node.right || parent.left != node.left))
      node.left = parent.left
    else
      node.left = parent
    end
    parent.left = left
    node.parent = grandparent
    parent.parent = node
    neighbor.parent = node unless neighbor.nil?
    grandparent.right == parent ? grandparent.right = node : grandparent.left = node unless grandparent.nil?
    right.parent = parent unless right.nil?
    left.parent = parent unless left.nil?
    @root = node if node.parent.nil?
  end

  # Recursive Depth First Search
  def find(data)
    root = @root
    queue = []
    while root
      queue.push(root.left) unless root.left.nil?
      return root if root.title == data
      root = root.right
      root = queue.shift if root.nil?
    end
  end

  def find_last_node
    queue = []
    last = @root
    queue.push(last.left) unless last.left.nil?
    queue.push(last.right) unless last.right.nil?
    while queue.any?
      last = queue.shift
      queue.push(last.left) unless last.left.nil?
      queue.push(last.right) unless last.right.nil?
    end
    last
  end

  def delete(data)
    return nil if data.nil?
    node = find(data)
    return nil if node.nil?
    last_node = find_last_node
    if node == last_node
      node == node.parent.right ? node.parent.right = nil : node.parent.left = nil
    else
      last_node.parent.right == last_node ? last_node.parent.right = nil : last_node.parent.left = nil
      last_node.left = node.left
      last_node.right = node.right
      last_node.parent = node.parent
      node == node.parent.right ? node.parent.right = last_node : node.parent.left = last_node
      unless last_node.left.nil?
        last_node.left.parent = last_node
        last_node.right.parent = last_node unless last_node.right.nil?
        left_rating = last_node.left.rating
        last_node.right.nil? ? right_rating = 100000 : right_rating = last_node.right.rating
        while last_node.rating > left_rating || last_node.rating > right_rating
          left_rating < right_rating ? swap(last_node.left, true) : swap(last_node.right, true)
          last_node.right.nil? ? right_rating = 100000 : right_rating = last_node.right.rating
          break if last_node.left.nil?
          left_rating = last_node.left.rating
        end
      end
      swap(last_node) while last_node != @root && last_node.rating < last_node.parent.rating
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    queue = []
    puts "#{@root.title}: #{@root.rating}\n"
    queue.push(@root.left) unless @root.left.nil? || @root.left.title == children
    queue.push(@root.right) unless @root.right.nil? || @root.right.title == children
    while queue.any?
      root = queue.shift
      puts "#{root.title}: #{root.rating}\n"
      queue.push(root.left) unless root.left.nil? || root.left.title == children
      queue.push(root.right) unless root.right.nil? || root.right.title == children
    end
  end
end
