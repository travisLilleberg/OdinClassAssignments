# frozen_string_literal: true

def permutations(array)
  return [[]] if array.empty?

  output = []
  permutation_helper(array, array.size, output)
  output
end

# rubocop:disable Metrics/MethodLength
def permutation_helper(array, size, output)
  if size == 1
    output << array.dup
    return
  end

  permutation_helper(array, size - 1, output)
  i = 0
  while i < size - 1
    if size.even?
      swap_values(array, i, size - 1)
    else
      swap_values(array, 0, size - 1)
    end

    permutation_helper(array, size - 1, output)
    i += 1
  end
end
# rubocop:enable Metrics/MethodLength

def swap_values(array, position1, position2)
  temp = array[position1]
  array[position1] = array[position2]
  array[position2] = temp
end
