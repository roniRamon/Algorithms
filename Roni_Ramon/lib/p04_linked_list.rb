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
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  def initialize
    @head = Node.new("head")
    @tail = Node.new("tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = get_node(key)
    if node == nil
      return nil
    end
    node.val
  end

  def get_node(key)
    return nil if first == nil
    node = first
    until node.key == 'tail'
      if node.key == key
        return node
      end
      node = node.next
    end
    nil
  end

  def include?(key)
    if get(key) == nil
      return false
    end
    true
  end

  def append(key, val)
    node = Node.new(key, val)
    @tail.prev.next = node
    @tail.prev = node
    node.next = @tail
    node.prev = @tail.prev
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
    current_node = @head.next
     until current_node == @tail
       yield current_node
       current_node = current_node.next
     end
   end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
