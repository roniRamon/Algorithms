class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.join.to_i.hash
  end
end

class String
  def hash
    arr = []
    self.each_byte do |char|
      arr.push(char)
    end
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr1 = self.keys
    arr2 = self.values
    all_items = []

    arr1.each do |el|
      if el.is_a? Numeric
        all_items.push(el)
      else
        el = el.to_s
        all_items.concat(el.bytes)
      end
    end
    arr2.each do |el|
      if el.is_a? Numeric
        all_items.push(el)
      elsif
        el = el.to_s
        all_items.concat(el.bytes)
      end
    end
    all_items.sort.hash
  end
end
