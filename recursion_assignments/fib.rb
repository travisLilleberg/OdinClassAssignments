# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
def fibs(num)
  i = 0
  output = []
  while i < num
    output << if i < 2
                i
              else
                output[i - 1] + output[i - 2]
              end

    i += 1
  end

  output
end
# rubocop:enable Metrics/MethodLength

def fibs_rec(num)
  fibs_rec_helper(num)
end

def fibs_rec_helper(max, iterator = 0, output = [])
  return output if iterator >= max

  output << if iterator < 2
              iterator
            else
              output[iterator - 1] + output[iterator - 2]
            end

  fibs_rec_helper(max, iterator + 1, output)
end

(0..10).each { |n| p fibs_rec(n) }
