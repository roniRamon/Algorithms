require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [2,1], [1,2], [3]]
    }
    @maze_cache = []
  end

# [1,2,6,13, 26, 48] n=4
# 13 + 26 = 38 + (2*(6-2) + 1)
  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?

    result = blair_nums(n - 1) + blair_nums(n - 2) + ((2 * (n - 2)) + 1)
    @blair_cache[n] = result
    result
  end

  def frog_hops_bottom_up(n) # 3
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    # take the last 3 resualts before n ex n = 4 take 3,2,1
    (@frog_cache.length + 1..n).each do |i|
      ans =  @frog_cache[i - 3].map { |el| el + [3] }
      ans2 = @frog_cache[i - 2].map { |el| el + [2] }
      ans3 = @frog_cache[i - 1].map { |el| el + [1] }
      @frog_cache[i] = ans + ans2 + ans3
    end
    @frog_cache[n]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return if n == 1
    frog_hops_top_down_helper(n - 1)
    if n > 3
      ans =  @frog_cache[n - 3].map { |el| el + [3] }
      ans2 = @frog_cache[n - 2].map { |el| el + [2] }
      ans3 = @frog_cache[n - 1].map { |el| el + [1] }
      @frog_cache[n] = ans + ans2 + ans3
    end
    @frog_cache[n]
  end

  def super_frog_hops(n, k)
    #base case
    super_cache = [ [[]], [[1]] ]
    # return super_cache[n] if n <= 1
    (super_cache.length..n).each do |j|
      arr = []
      counter = super_cache.length >= k ? super_cache.length - k : 0
      (counter..super_cache.length-1).each do |i|
        diff = (i - j).abs
        if diff <= k
          arr += super_cache[i].map { |steps| steps + [diff]}
        end
      end
      super_cache.push(arr)
    end

    super_cache[n]
  end

  # input:  weight = [1, 2, 3]
  #         values = [10, 4, 8]
  #         capacity = 3
  # output: 10 + 4 = 14
  def knapsack(weights, values, capacity)
    return 0 if capacity <= 0 || weights.empty? || values.empty?
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    solution_table = []  # solution_table[0] = [] 0,

    (0..capacity).each do |i| # 0..3 ,0, 1
      solution_table[i] = []
      #Go throught the weights one by one by index
      values.length.times.each do |j| # 0..3 0,1, 2
        if i == 0                     # 0 == 0 true
          # if capacity is zero. then 0 is the only value that can be placed into the set
          solution_table[i][j] = 0 # solution_table[0][0] = 0 solution_table = [[0,0,0], [1, 1, 1, ]]
        elsif j == 0
          # for the first item in our list we can check fot capacity
          # if our weights < capacity, put zero, otherwise put valye
          solution_table[i][j] = weights[0] > i ? 0 : values.first
        else
          # the first option is the entery considering the previous item at this capacity
          option1 = solution_table[i][j - 1]   # 1, 1
          #the secound option (assuming enough capacity)- is the max value of the smaller bag
          option2 = i < weights[j] ? 0 : solution_table[i - weights[j]][j - 1] + values[j] # 0
          #choose max from this options
          optimum = [option1, option2].max # [1,0] 1 = max
          solution_table[i][j] = optimum
        end
      end
    end
    solution_table
  end


  def maze_solver(maze, start_pos, end_pos)
    @maze_cache[start_pos] = nil
    queue = [start_pos]

    until queue.empty?
      current = queue.pop
      break if current == end_pos

      get_moves(maze, current).each do |move|
        @maze_cache[move] = current
        queue << move
      end

    end

    @maze_cache.include?(end_pos) ? path_from_cache(end_pos) : nil
  end

  def get_moves(maze, pos)
    x, y = pos
    moves = []
    directions = [[1,0], [-1,0], [0,1], [0, -1]]

    directions.each do |new_x, new_y|
      next_pos = [x + new_x, y + new_y]

      if is_valid_pos?(maze, next_pos)
        moves << next_pos unless @maze_cache.include?(next_pos)
      end
    end
    moves
  end

  def is_valid_pos?(maze, pos)
    x, y = pos
    x >= 0 && y >= 0 && x < maze.length && y < maze.length && maze[x][y] != "X"
  end

  def path_from_cache(end_pos)
    path = []
    current = end_pos

    while current
      path.unshift(current)
      current = @maze_cache[current]
    end

    path
  end

end
