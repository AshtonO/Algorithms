# returns all permutations of items
# e.g. [1, 2, 3] should return [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
def permutations(items, allow_duplicates)
  return [] if items.size == 0
  items.sort! if allow_duplicates
  backtrack([], [], items, allow_duplicates)
end

def backtrack(results, current, items, duplicates_allowed)
  results.push(current) if items.size == 0
  (0...items.size).each do |i|
    next if i > 0 and items[i] == items[i-1]
    backtrack(results, 
              current + [items[i]], 
              items[0...i] + items[i+1...items.size],
              duplicates_allowed)
  end
  results
end

def test
  test_cases = { 
    [] => [],
    [1] => [[1]],
    [1, 2] => [[1, 2], [2, 1]],
    [1, 2, 3] => [ [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]],
    [1, 2, 2] => [ [1, 2, 2], [2, 1, 2], [2, 2, 1] ]
  }

  test_result = true

  test_cases.each do |input, expected_result|
    actual_result = permutations(input, true)
    unless actual_result == expected_result
      puts "Failed test #{input}\n Expected: #{expected_result}\nActual: #{actual_result}"
      test_result = false
    end
  end
  return test_result
end

puts "Running test"
puts "Success!" if test
