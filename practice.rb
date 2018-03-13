# for top-down dp problems
class DynamicProgramming
  attr_reader :blair_cache
  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
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
end

#bottom up approach
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
