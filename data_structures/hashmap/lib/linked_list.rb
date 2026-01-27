# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

# A ruby implementation of a linked list of key value pairs.
class LinkedList
  def initialize
    @head = nil
  end

  def get(key)
    return nil if @head.nil?

    iterate { |pair| return pair[:value] if pair[:key] == key }

    nil
  end

  def set(key, value)
    if @head.nil?
      @head = { key: key, value: value, next: nil }
      return
    end

    iterate do |pair|
      if pair[:key] == key
        pair[:value] = value
        break
      elsif pair[:next].nil?
        pair[:next] = { key: key, value: value, next: nil }
      end
    end
  end

  def remove(key)
    return nil if @head.nil?

    if @head[:key] == key
      value = @head[:value]
      @head = @head[:next]
      return value
    end

    remove_iterate(key)
  end

  def has?(key)
    return false if @head.nil?

    iterate { |pair| return true if pair[:key] == key }

    false
  end

  def length
    count = 0
    iterate { count += 1 }
    count
  end

  # Valid types are :pair, :key, or :value.
  def keys_or_values(type = :pair)
    output = []
    if type == :pair
      iterate { |pair| output << [pair[:key], pair[:value]] }
    else
      iterate { |pair| output << pair[type] }
    end
    output
  end

  def clear
    @head = nil
  end

  private

  def iterate
    return if @head.nil?

    current = @head
    while current
      yield current
      current = current[:next]
    end
  end

  def remove_iterate(key)
    value = nil
    iterate do |pair|
      if !pair[:next].nil? && pair[:next][:key] == key
        value = pair[:next][:value]
        pair[:next] = pair[:next][:next]
      end
    end

    value
  end
end

# rubocop:enable Metrics/MethodLength
