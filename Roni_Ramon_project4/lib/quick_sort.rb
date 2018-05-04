require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.shift
    left = []
    right = []
    array.each do |el|
      right.push(el) if el > pivot
      left.push(el) if el <= pivot
    end

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)


  end

  def self.partition(array, start, length, &prc)
    end_idx = (start + length)
    pivot_idx = start
    pivot = array[pivot_idx]
    border_idx = start + 1

    (start...end_idx).each_with_index do |i|
      if i != pivot_idx
        if pivot > array[i]
          array[border_idx], array[i] = array[i], array[border_idx]
          border_idx += 1
        end
      end
    end
    array[pivot_idx], array[border_idx-1] = array[border_idx-1], array[pivot_idx]
    pivot_idx = start
    p array
    pivot = array[pivot_idx]
  end

end
