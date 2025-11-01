# frozen_string_literal: true

def bubble_sort(arr)
  j = arr.length - 1
  while j > 0
    i = 0
    while i < j
      arr[i], arr[i + 1] = arr[i + 1], arr[i] if arr[i] > arr[i + 1]
      i += 1
    end
    j -= 1
  end

  arr
end

arr = [*1..20].shuffle
p arr
p bubble_sort(arr)
