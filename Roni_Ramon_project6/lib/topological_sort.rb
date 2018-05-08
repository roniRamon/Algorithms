require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top = Queue.new

  # collect node with no in edges
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top.enq(vertex)
      vertices.delete(vertex)
    end
  end

  # While the queue is not empty
  while !top.empty?
    # debugger
    current = top.pop
    sorted.push(current)


    # destroy edges
     # debugger
     counter = current.out_edges.length - 1
     while counter >= 0
      current.out_edges[counter].to_vertex.in_edges.delete(current.out_edges[counter])
      current.out_edges[counter]
      counter -= 1
    end

    vertices.each do |vertex|
      if vertex.in_edges.empty?
        top.enq(vertex)
        vertices.delete(vertex)
      end
    end
  end

  return [] if !vertices.empty?
  sorted
end
