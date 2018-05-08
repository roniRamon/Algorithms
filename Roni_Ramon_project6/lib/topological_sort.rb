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
    end
  end

  # While the queue is not empty
  while !top.empty?
    # debugger
    current = top.pop
    sorted.push(current)
    vertices.delete(current)

    # destroy edges
    current.out_edges.each(&:edge.destroy!)

    vertices.each do |vertex|
      if vertex.in_edges.empty?
        top.enq(vertex)
      end
    end
  end

  sorted
end
