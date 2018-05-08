# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'
require 'byebug'

def install_order(arr)
  # loop over array
  vertices = []
  max = 0
  arr.each do |tuple|
    # check if tuple value in vertices
    max = tuple[0] if max < tuple[0]
    max = tuple[1] if max < tuple[1]
    parent_node = check_for_val(tuple[0], vertices) || Vertex.new(tuple[0])
    child_node = check_for_val(tuple[1], vertices)  || Vertex.new(tuple[1])

    vertices.push(parent_node) if !vertices.include?(parent_node)
    vertices.push(child_node) if !vertices.include?(child_node)

    Edge.new(parent_node, child_node)
  end

  result = topological_sort(vertices)

  max.times do |val|
    if check_for_val(val+1, result) == nil
      result.push(Vertex.new(val+1))
    end
  end

  result2 = []
  result.each_with_index do |vertex, i|
    result2.push(vertex.value)
  end
  result2
end

def check_for_val(value, arr)
  arr.each do |node|
    return node if node.value == value
  end
  nil
end
