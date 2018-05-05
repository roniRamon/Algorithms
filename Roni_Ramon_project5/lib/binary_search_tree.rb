# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'
require 'byebug'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil

  end

  def insert(value, tree_node = @root)
    if tree_node == @root && tree_node.nil?
      @root = BSTNode.new(value)
    elsif tree_node.value >= value #left - child: compare nodes
      if tree_node.left.nil? #no child == insert
        tree_node.left = BSTNode.new(value)
        tree_node.left.parent = tree_node
      else
        insert(value, tree_node.left)
      end
    elsif tree_node.value < value # right
      if tree_node.right.nil? #no child == insert
        tree_node.right = BSTNode.new(value)
        tree_node.right.parent = tree_node
      else
        insert(value, tree_node.right)
      end
    end
    tree_node
  end

  def find(value, tree_node = @root)
    if tree_node.nil?
      nil
    elsif tree_node.value == value
      tree_node
    elsif tree_node.value >= value
      find(value, tree_node.left)
    elsif tree_node.value < value
      find(value, tree_node.right)
    end
  end

  def delete(value)
    delete_node = find(value)

    if delete_node.nil?
      return
    else
      # NO children
      if delete_node.left.nil? && delete_node.right.nil?
        # delete node
        if !delete_node.parent.nil?
          delete_node.parent.left = nil if delete_node.parent.left == delete_node
          delete_node.parent.right = nil if delete_node.parent.right == delete_node
          delete_node.parent = nil
        end
        @root = nil if delete_node == @root
        # has children
      elsif !delete_node.left.nil? && !delete_node.right.nil?
        max_node = maximum(delete_node.left)
        #change max node child and parent pointers
        if !max_node.left.nil? #true
          max_node.left.parent = max_node.parent
          max_node.parent.right = max_node.left
          max_node.parent = nil
          max_node.left = nil
        end
        #change max node pointer
        delete_node.left.parent = max_node
        delete_node.right.parent = max_node
        delete_node.parent.left = max_node

        max_node.parent = delete_node.parent
        max_node.left = delete_node.left
        max_node.right = delete_node.right

      elsif delete_node.left.nil?
        delete_node.right.parent = delete_node.parent
        delete_node.parent.left = delete_node.right if delete_node.parent.left == delete_node
        delete_node.parent.right = delete_node.right if delete_node.parent.right == delete_node
      else
        delete_node.left.parent = delete_node.parent
        delete_node.parent.left = delete_node.left if delete_node.parent.left == delete_node
        delete_node.parent.right = delete_node.left if delete_node.parent.right == delete_node
      end
      delete_node = nil
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      tree_node
    else
      maximum(tree_node.right)
    end
  end


  def depth(tree_node = @root)
    return -1 unless tree_node
    left = depth(tree_node.left)
    right = depth(tree_node.right)

    left > right ? left + 1 : right + 1
  end

  def is_balanced?(tree_node = @root)
    depths = []
    stack = []

    stack.push([tree_node, 0])

    while stack.length > 0
      tree_node, depth = stack.pop
      if !tree_node.left && !tree_node.right
        if !depths.include?(depth)
          depths << depth
          if depths.length > 2 || (depths.length == 2 && (depth[0] - depth[1]).abs > 1)
            return false
          end
        end
      else
        stack.push([tree_node.left, depth + 1]) if tree_node.left
        stack.push([tree_node.right, depth + 1]) if tree_node.right
      end
    end

    true
  end

  def in_order_traversal(tree_node = @root)
    arr = []
    traversal(tree_node, arr)
    arr
  end

  def traversal(tree_node = @root, arr = [])
    return arr unless tree_node
    traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    traversal(tree_node.right, arr) if tree_node.right
  end


  private
  # optional helper methods go here:

end
