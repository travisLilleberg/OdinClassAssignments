# frozen_string_literal: true

# def substrings(search, dictionary)
#   word_hash = Hash.new(0)
#   dictionary.each do |word|
#     sum = search.downcase.scan(/#{word.downcase}/).count
#     word_hash[word] = sum if sum > 0
#   end

#   word_hash
# end

# I think the solution they want is this, but it doesn't allow for the substring to be in a single word multiple times:
def substrings(haystack, needles)
  output_word_hash = Hash.new(0)
  straws = haystack.split
  needles.each do |needle|
    sum = straws.reduce(0) do |sum, straw|
      straw.downcase.include?(needle.downcase) ? sum + 1 : sum
    end

    output_word_hash[needle] = sum if sum.positive?
  end

  output_word_hash
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
p substrings('below', dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
