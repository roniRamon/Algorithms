require_relative 'p02_hashing'
require 'byebug'
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    @count += 1
    self[key.hash].push(key)
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    @count -= 1 if self.include?(key)
    self[key.hash].delete(key) if self.include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_buckets].push(el)
      end
    end
    @store = new_store
  end
end
