# frozen_string_literal: true

def total_integers(array)
  count = 0
  array.each do |val|
    count += count_integers(val)
  end

  count
end

def count_integers(val)
  case val
  in Integer
    1
  in Array
    total_integers(val)
  else
    0
  end
end
