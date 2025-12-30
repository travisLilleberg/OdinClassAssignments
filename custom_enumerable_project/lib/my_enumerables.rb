# frozen_string_literal: true

##
# An assignment to rewrite basic enumerable functionality.
module Enumerable
  def my_each_with_index
    if block_given?
      i = 0
      while i < length
        yield(self[i], i)
        i += 1
      end
    end

    self
  end

  def my_select
    output = []
    my_each { |item| output << item if yield item }
    output
  end

  def my_all?
    my_each { |item| return false unless yield item }
    true
  end

  def my_any?
    my_each { |item| return true if yield item }
    false
  end

  def my_none?
    my_each { |item| return false if yield item }
    true
  end

  def my_count
    return length unless block_given?

    count = 0
    my_each { |item| count += 1 if yield item }

    count
  end

  def my_map
    return self unless block_given?

    output = []
    my_each { |item| output << yield(item) }

    output
  end

  def my_inject(initial_value = nil)
    return initial_value unless length

    initial_value ||= shift
    my_each { |item| initial_value = yield(initial_value, item) }

    initial_value
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    if block_given?
      # rubocop:disable Style/For
      for item in self
        yield item
      end
      # rubocop:enable Style/For
    end

    self
  end
end
