class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end
end
