# frozen_string_literal: true

def pascal(row_number)
  return [1] if row_number == 1

  input = pascal(row_number - 1)
  output = [1]
  i = 0

  until input[i + 1].nil?
    output << (input[i] + input[i + 1])
    i += 1
  end

  output << 1

  output
end
