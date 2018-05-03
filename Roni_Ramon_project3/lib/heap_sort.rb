require_relative "heap"

class Array
  def heap_sort!
    # [6,4,5,7,8]
    boundary_idx = 0
    #heapify array in place from big to small
    # [6,4] [5,7,8]
    while boundary_idx < self.length - 1
      boundary_idx += 1
      heapify_up(self, boundary_idx, self.length)
    end

    # heapify_down to extract items pass
    #switch place
    while boundary_idx > 1
      self[0], self[boundary_idx] = self[boundary_idx], self[0]
      #move boundary_idx - 1
      heapify_down(self, 0, boundary_idx)
      boundary_idx -= 1
    end

    if self[0] > self[1]
      self[0], self[1] = self[1], self[0]
    end

  end

  private
  def child_indices(len, parent_index)
    child = []
    calc = 2 * parent_index
    child.push(calc + 1) if (calc + 1) < len
    child.push(calc + 2) if (calc + 2) < len
    child
  end

  def parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def heapify_up(array, child_idx, len = array.length, &prc)
    return if child_idx == 0
    parent_idx = parent_index(child_idx)

    while array[child_idx] > array[parent_idx]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      return array if child_idx == 0
      parent_idx = parent_index(child_idx)
    end
    array
  end

  def heapify_down(array, parent_idx, len = array.length, &prc)
    children = child_indices(len, parent_idx)
    largest = nil
    if children.length == 2
      # largest = prc.call(array[children[0]], array[children[1]]) == -1 ? children[1] : children[0]
      largest = array[children[0]] < array[children[1]] ? children[1] : children[0]
    elsif children.length == 1
      largest = children[0]
    end

    until children.empty? || array[parent_idx] > array[largest]
      array[parent_idx], array[largest] = array[largest], array[parent_idx]
      parent_idx = largest
      children = child_indices(len, parent_idx)
      if children.length == 2
        largest = array[children[0]] < array[children[1]] ? children[1] : children[0]
        # largest = prc.call(array[children[0]], array[children[1]]) == -1 ? children[1] : children[0]
      elsif children.length == 1
        largest = children[0]
      end
    end
    array
  end

end
