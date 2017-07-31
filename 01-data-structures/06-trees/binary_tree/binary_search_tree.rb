require_relative 'node'
require 'benchmark'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    if node.rating < root.rating
      if root.left.nil?
        root.left = node
      else
        insert(root.left, node)
      end
    else
      if root.right.nil?
        root.right = node
      else
        insert(root.right, node)
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    queue = []
    while root
      queue.push(root.left) unless root.left.nil?
      return root if root.title == data
      root = root.right
      root = queue.shift if root.nil?
    end
  end

  def left_leaf(root, pop = false)
    return root if root.left.nil?
    while root.left
      if root.left.left.nil?
        leaf = root.left
        root.left = nil if pop == true
        return leaf
      end
      root = root.left
    end
  end

  def delete(root, data)
    queue = []
    queue.push(root)
    while queue.any?
      root = queue.shift
      break if (!root.left.nil? && root.left.title == data) || (!root.right.nil? && root.right.title == data)
      queue.push(root.left) unless root.left.nil?
      queue.push(root.right) unless root.right.nil?
    end
    if !root.right.nil? && root.right.title == data
      to_delete = root.right
    elsif !root.left.nil? && root.left.title == data
      to_delete = root.left
    end
    return nil if to_delete.nil?
    if to_delete.right.nil? && to_delete.left.nil?
      !root.right.nil? && root.right.title == data ? root.right = nil : root.left = nil
    elsif to_delete.right.nil? || to_delete.left.nil?
      next_node = to_delete.right || to_delete.left
      !root.right.nil? && root.right.title == data ? root.right = next_node : root.left = next_node
    else
      next_node = left_leaf(to_delete.right, true)
      next_node.right = to_delete.right unless to_delete.right == next_node
      next_node.left = to_delete.left unless to_delete.left == next_node
      !root.right.nil? && root.right.title == data ? root.right = next_node : root.left = next_node
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
