# returns all possible subsets for the provided items
# e.g. [1, 2, 3] should include all of the following subsets:
# [ [], [1], [1, 2], [1, 3], [1, 2, 3], [2], [2, 3], [3] ]
# duplicates_allowed defines whether there are duplicates allowed in the set
def subsets(items, duplicates_allowed = false)
  if duplicates_allowed
    items.sort!
  end
  backtrack([], [], items, 0, duplicates_allowed)
end

def backtrack(result, current, items, start, duplicates_allowed)
  result.push(current)
  (start...items.size).each do |i|
    # if duplicates are allowed, we'll have sorted above in subsets, so we can
    # make sure we don't backtrack on the same number (i.e. so sets like [1, 2, 2] dont end up putting 2 copies of [2], [1, 2] and [2, 2] in results)
    next if duplicates_allowed and i > start and items[i] == items[i-1] 
    backtrack(result, current + [items[i]], items, i+1, duplicates_allowed)
  end
  result
end

def test
  test_cases = { 
    [] => [[]],
    [1] => [[], [1]],
    [1, 2] => [[], [1], [1, 2], [2]],
    [1, 2, 3] => [ [], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3] ],
    [1, 2, 2] => [ [], [1], [1, 2], [1, 2, 2], [2], [2, 2] ]
  }

  test_result = true

  test_cases.each do |input, expected_result|
    actual_result = subsets(input, true)
    unless actual_result == expected_result
      puts "Failed test #{input}\n Expected: #{expected_result}\nActual: #{actual_result}"
      test_result = false
    end
  end
  return test_result
end

puts "Running test"
puts "Success!" if test
