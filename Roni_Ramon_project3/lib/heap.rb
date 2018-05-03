require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    prc ||= Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    return if @store.length < 2
    last = count - 1
    @store[0], @store[last] = @store[last], @store[0]
    pop_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    pop_el
  end

  def peek
    @store[0]
  end

  def push(val)
    # debugger
    @store.push(val)
    child_index = count - 1
    BinaryMinHeap.heapify_up(@store, child_index)
    @store
  end

  public
  def self.child_indices(len, parent_index)
    child = []
    calc = 2 * parent_index
    child.push(calc + 1) if (calc + 1) < len
    child.push(calc + 2) if (calc + 2) < len
    child
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = self.child_indices(len, parent_idx)
    smallest = nil
    if children.length == 2
      # smallest = prc.call(array[children[0]], array[children[1]]) == -1 ? children[1] : children[0]
      smallest = array[children[0]] > array[children[1]] ? children[1] : children[0]
    elsif children.length == 1
      smallest = children[0]
    end

    until children.empty? || array[parent_idx] < array[smallest]
      array[parent_idx], array[smallest] = array[smallest], array[parent_idx]
      parent_idx = smallest
      children = self.child_indices(len, parent_idx)
      if children.length == 2
        smallest = array[children[0]] > array[children[1]] ? children[1] : children[0]
        # smallest = prc.call(array[children[0]], array[children[1]]) == -1 ? children[1] : children[0]
      elsif children.length == 1
        smallest = children[0]
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return if child_idx == 0
    parent_idx = self.parent_index(child_idx)

    while array[child_idx] < array[parent_idx]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      return array if child_idx == 0
      parent_idx = self.parent_index(child_idx)
    end
    array
  end
end
