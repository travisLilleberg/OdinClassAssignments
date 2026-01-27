# frozen_string_literal: true

require_relative 'linked_list'

# An implementation of a hashmap using Ruby.
class HashMap
  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    # https://www.geeksforgeeks.org/dsa/what-are-hash-functions-and-how-to-choose-a-good-hash-function/ .
    @c = 0.6180339887498949
    @buckets = Array.new(@capacity) { LinkedList.new }
    @total_buckets = @capacity
  end

  def set(key, value)
    expand_capacity if used_buckets.to_f / @total_buckets >= @load_factor

    @buckets[hash(key)].set(key, value)
  end

  def get(key)
    @buckets[hash(key)].get(key)
  end

  def has?(key)
    @buckets[hash(key)].has?(key)
  end

  def remove(key)
    @buckets[hash(key)].remove(key)
  end

  def length
    @buckets.reduce(0) { |sum, list| sum + list.length }
  end

  def clear
    @buckets.each { |list| list.clear if list.length }
  end

  def keys
    @buckets.reduce([]) { |keys, list| keys + list.keys_or_values(:key) }
  end

  def values
    @buckets.reduce([]) { |keys, list| keys + list.keys_or_values(:value) }
  end

  def entries
    @buckets.reduce([]) { |keys, list| keys + list.keys_or_values }
  end

  def to_s
    @buckets.each_with_index do |list, idx|
      puts "\n Index #{idx}:"
      p list.keys_or_values
    end
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = ((prime_number * hash_code) + char.ord) }

    # See where @c is set in initialize for link.
    hash = (@total_buckets * ((hash_code * @c) % 1)).floor
    raise IndexError if hash.negative? || hash >= @total_buckets

    hash
  end

  def used_buckets
    # rubocop:disable Style/ZeroLengthPredicate
    @buckets.reduce(0) { |sum, list| list.length > 0 ? sum + 1 : sum }
    # rubocop:enable Style/ZeroLengthPredicate
  end

  def expand_capacity
    @buckets += Array.new(@capacity) { LinkedList.new }
    @total_buckets += @capacity
  end
end
