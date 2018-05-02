require 'byebug'
class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > 0 && num < @max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    @count += 1
    self[num].push(num)
  end

  def remove(num)
    @count -= 1 if self.include?(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num)
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
