require 'byebug'
# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax < RingBuffer
  attr_accessor :store

  def initialize
    super()
  end

  def enqueue(val)
    push(val)
  end

  def dequeue
    shift
  end

  def max
    arr = []
    index = 0
    until arr.length == length
      arr.push(@store[(@start_idx + index) % capacity])
      index += 1
    end
    arr.max
  end

  def length
    @length
  end

end
