require_relative 'graph'
require 'byebug'
require 'set'
# Implementing topological sort using both Khan's and Tarian's algorithms

# def topological_sort_my_solution(vertices)
#   sorted = []
#   top = Queue.new
#   # collect node with no in edges
#   vertices.each do |vertex|
#     if vertex.in_edges.empty?
#       top.enq(vertex)
#       vertices.delete(vertex)
#     end
#   end
#
#   # While the queue is not empty
#   while !top.empty?
#     current = top.pop
#     sorted.push(current)
#
#     # destroy edges
#     counter = current.out_edges.length - 1
#     while counter >= 0
#       current.out_edges[counter].to_vertex.in_edges.delete(current.out_edges[counter])
#       current.out_edges[counter]
#       counter -= 1
#     end
#
#     vertices.each do |vertex|
#       if vertex.in_edges.empty?
#         top.enq(vertex)
#         vertices.delete(vertex)
#       end
#     end
#   end
#
#   return [] if !vertices.empty?
#   sorted
# end



## khan's Algorithm
def topological_sort(vertices)
  order = []
  in_edges = {}
  queue = []

  vertices.each do |vertex|
    in_edge_cost = vertex.in_edges.reduce(0) { |sum, edge| sum += edge.cost}
    in_edges[vertex] = in_edge_cost
    queue << vertex if in_edge_cost == 0
  end

  until queue.empty?
    current = queue.shift

    current.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      in_edges[to_vertex] -= edge.cost
      queue << to_vertex if in_edges[to_vertex] == 0
    end

    order << current
  end

  vertices.length == order.length ? order : []
end

## Tarjan's Algorithm
def topological_sort_tarjan(vertices)
  order = []
  explored = Set.new

  vertices.each do |vertex|
    dfs!(order, explored, vertex) unless explored.include?(vertex)
  end

  order
end

def dfs!(order, explored, vertex)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    dfs!(order, explored, to_vertex) unless explored.include?(to_vertex)
  end

  order.unshift(vertex)
end
