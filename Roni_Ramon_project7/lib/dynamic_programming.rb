require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [2,1], [1,2], [3]]
    }
  end

# [1,2,6,13, 26, 48] n=4
# 13 + 26 = 38 + (2*(6-2) + 1)
  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?

    ans = blair_nums(n - 1) + blair_nums(n - 2) + ((2 * (n - 2)) + 1)
    @blair_cache[n] = ans
    return ans
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

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
