# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def merge_sort(arr)
  return arr if arr.size <= 1

  middle = (arr.size / 2).floor
  left_arr = merge_sort(arr[0, middle])
  right_arr = merge_sort(arr.slice(middle..-1))

  left_i = right_i = 0
  output = []
  while left_i < left_arr.size || right_i < right_arr.size
    # If right array is empty ...
    unless right_i < right_arr.size
      output, left_i = merge_sort_output_and_increment(output, left_arr, left_i)
      next
    end

    # If left array is empty OR left array value is bigger ...
    if left_i >= left_arr.size || left_arr[left_i] > right_arr[right_i]
      output, right_i = merge_sort_output_and_increment(output, right_arr, right_i)
    # Both arrays are not empty and right array is bigger ...
    else
      output, left_i = merge_sort_output_and_increment(output, left_arr, left_i)
    end
  end

  output
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

def merge_sort_output_and_increment(output, array, iterator)
  output << array[iterator]
  [output, iterator + 1]
end

test = [*1..21].shuffle
p test
p merge_sort(test)
