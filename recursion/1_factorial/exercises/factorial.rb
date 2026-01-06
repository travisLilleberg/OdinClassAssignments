# frozen_string_literal: true

def factorial(num)
  if num < 0
    nil
  elsif num <= 1
    1
  else
    num * factorial(num - 1)
  end
end
