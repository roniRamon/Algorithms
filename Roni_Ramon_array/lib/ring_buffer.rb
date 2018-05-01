
require_relative "static_array"

class RingBuffer < StaticArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    super(@capacity)
  end

  # O(1)
  def [](index)
    if @store[(@start_idx + index) % @capacity] == nil
      raise "index out of bounds"
    elsif @store[@start_idx + index] == nil
      index = (@start_idx + index) % @capacity
      return @store[index]
    end
    @store[@start_idx + index]
  end

  # O(1)
  def []=(index, val)
    if @store[(@start_idx + index) % @capacity] == nil
      raise "index out of bounds"
    else
      index = (@start_idx + index) % @capacity
      @store[index] = val
    end
    @store[@start_idx + index] = val
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end
    @length -= 1
    pop_el = @store[(@start_idx + @length) % @capacity]
    @store[(@start_idx + @length) % @capacity] = nil
    pop_el
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
      @store[(@start_idx + @length) % @capacity] = val
      @length += 1
    else
      @store[(@start_idx + @length) % @capacity] = val
      @length += 1
    end
  end

  # O(1)
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    shif_el = @store[@start_idx]
    @store[@start_idx] = nil
    @length -= 1
    @start_idx = (@start_idx + 1) % @capacity
    shif_el
  end

  # O(1) ammortized
  def unshift(val)
    if @capacity == @length
      resize!
    end
    if @start_idx > 0 && @store[@start_idx - 1] == nil
      @start_idx -= 1
      @length += 1
      @store[@start_idx] = val
    elsif @store[@capacity - 1] == nil
      @store[@capacity - 1] = val
      @start_idx = (@capacity - 1)
      @length += 1
    end
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = Array.new(new_capacity)

    index = 0
    until @length == index
      new_store[index] = @store[(@start_idx + index) % @capacity]
      index += 1
    end
    @start_idx = 0
    @store = new_store
    @capacity = new_capacity
  end

end
