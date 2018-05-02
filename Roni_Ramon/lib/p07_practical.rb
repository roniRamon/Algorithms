require_relative 'p05_hash_map'
require 'byebug'
def can_string_be_palindrome?(string)
  hash_map = HashMap.new(string.length)

  string.chars do |char|
    if hash_map.include?(char)
       hash_map[char] = hash_map[char] + 1
    else
      hash_map.set(char, 1)
    end
  end

  counter = 0
  hash_map.each do |bucket|
    if bucket[1].odd?
      counter += 1
    end
  end
  return false if counter > 1
  true  
end
