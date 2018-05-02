require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    j = 0
    each do |node|
       return node if i == j
       j += 1
     end
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = get_node(key)
    return nil if node == nil
    node.val
  end

  def get_node(key)
    return nil if first == nil
    node = first
    until node == @tail
      if node.key == key
        return node
      end
      node = node.next
    end
    nil
  end

  def include?(key)
    return false if get(key) == nil
    true
  end

  def append(key, val)
    node = Node.new(key, val)
    @tail.prev.next = node
    node.prev = @tail.prev
    @tail.prev = node
    node.next = @tail
    node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val if include?(key)
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end

    nil
  end

  def each
     node = @head.next
     until node == @tail
       yield node
       node = node.next
     end
   end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
