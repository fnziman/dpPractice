require 'byebug'

# for top-down dp problems
class DynamicProgramming
  attr_reader :blair_cache, :hops_cache, :super_hops_cache

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @hops_cache = { 
      1 => [[1]], 
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
            }
    @super_hops_cache = { }
  end
  
  # The first Blair number, b1, is 1,
  # The second Blair number, b2, is 2,
  # The kth Blair number is the sum of the previous two 
  # Blair numbers plus the (k - 1)th odd number. 
  # For example, b3 = b2 + b1 + 2nd odd = 1 + 2 + 3 = 6.
  
  #top down approach
  def blair_numbers(n) #returns nth blair number
    # return n if n == 1 || n == 2
    return @blair_cache[n] unless @blair_cache[n].nil?
    
    ans = blair_numbers(n - 1) + blair_numbers(n - 2) + (((n - 1) * 2) - 1)
    @blair_cache[n] = ans
  end
  #########################################
  # A frog is sitting at the bottom of a staircase with n stairs.
  # Tiny little frog can only jump so many steps at once. 
  # In particular, it can only hop 1, 2, or 3 steps at a time. 
  def frog_hops(n)
    frog_hops_helper(n)
  end
  
  def frog_hops_helper(n)
    return @hops_cache[n] unless @hops_cache[n].nil?
    
    cur_cache = []
    cur_cache.concat(frog_hops_helper(n - 3).map{ |el| el += [3]})
    cur_cache.concat(frog_hops_helper(n - 2).map{ |el| el += [2]})
    cur_cache.concat(frog_hops_helper(n - 1).map{ |el| el += [1]})
    @hops_cache[n] = cur_cache
  end
  #########################################
  
  # Write a function, super_frog_hops(num_stairs, max_stairs) 
  # that takes in the number of stairs and the maximum number 
  # of stairs that can be hopped at once, and returns the set 
  # of ways this frog can make its journey.
  def super_frog_hops(num_stairs, max_hop)
    return 1 if num_stairs == 1
    return at_max(num_stairs) if num_stairs <= max_hop
    return @super_hops_cache[num_stairs] unless @super_hops_cache[num_stairs].nil?
    
    ans = 0
    (1..max_hop).each do |i|
      ans += super_frog_hops(num_stairs - i, max_hop)
      @super_hops_cache[num_stairs] = ans
    end
    return ans
  end
  
  def at_max(n)
    prev = 1
    (n-1).times do 
      prev = prev * 2
    end
    prev
  end
  
  #bottom up approach
  ######################################
  def blair_numbers_2(n)
    numbers = create_blair_numbers(n)
    numbers[n]
  end

  def create_blair_numbers(n)
    result= { 1 => 1, 2 => 2 }
    
    (3..n).each do |num|
      result[num] = result[num - 1] + result[num - 2] + ((num - 1) * 2) - 1
    end
    result
  end
####################################
  def frog_hops_bottom_up(n)
    result = frog_hops_cache_builder(n)
    result[n]
  end

  def frog_hops_cache_builder(n)
    cache = { 
      1 => [[1]], 
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
            }
    
    (4..n).each do |step|
      cur_cache = []
      cur_cache.concat(cache[step - 1].map{ |el| el += [1] })
      cur_cache.concat(cache[step - 2].map{ |el| el += [2] })
      cur_cache.concat(cache[step - 3].map{ |el| el += [3] })
      cache[step] = cur_cache
    end
    return cache
  end
  ###################################
end
