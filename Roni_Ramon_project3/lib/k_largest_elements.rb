require_relative 'heap_sort'

def k_largest_elements(array, k)
  array.heap_sort!
  array[-k..-1]
end


# [6,4,2,7,2,8,0]
# k = ?
#
