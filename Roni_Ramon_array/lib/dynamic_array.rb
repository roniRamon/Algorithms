require_relative "static_array"

class DynamicArray < StaticArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    super(@capacity)
  end

  # O(1)
  def [](index)
    if index >= @length || index < 0
      raise "index out of bounds"
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index >= @length || index < 0
      raise "index out of bounds"
    end
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end
    @store[@length-1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)

    if @length == @capacity
      resize!
      @length += 1
      @store[@length-1] = val
    else
      @store[@length] = val
      @length += 1
    end

  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    shif_el = @store[@start_idx]
    @store[@start_idx] = nil
    @length -= 1
    @start_idx += 1
    return shif_el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      resize_unshift(@capacity*2)
      @length += 1
      @store[0] = val
    else
      resize_unshift(@capacity)
      @store[0] = val
      @length += 1
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    new_store = Array.new(@capacity)
    @store.each_with_index do |el, idx|
      new_store[idx] = el
    end
    @store = new_store
  end

  def resize_unshift(size)
    @capacity = size
    new_store = Array.new(@capacity)
    @store.each_with_index do |el, idx|
      new_store[idx+1] = el
    end
    @store = new_store
  end


end
