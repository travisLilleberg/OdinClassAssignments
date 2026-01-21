# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ClassLength

# An implementation of a linked list using Ruby.
class LinkedList
  # An implementation of a node object for use in the linked list.
  class Node
    attr_accessor :value, :next

    def initialize(value, nxt = nil)
      @value = value
      @next = nxt
    end
  end

  def initialize
    @head = @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = @tail = node
    else
      @tail.next = node
      @tail = @tail.next
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size
    count = 0
    iterate { count += 1 }
    count
  end

  def head
    @head&.value
  end

  def tail
    @tail&.value
  end

  def at(target_index)
    return nil if @head.nil?

    output = nil
    iterate do |node|
      if target_index == 0
        output = node.value
        break
      else
        target_index -= 1
      end
    end

    output
  end

  def pop
    return nil if @head.nil?

    value = @head.value
    @head = @head.next
    value
  end

  def contains?(search)
    iterate { |node| return true if search == node.value }

    false
  end

  def index(search)
    index = 0
    iterate do |node|
      return index if node.value == search

      index += 1
    end

    nil
  end

  def to_s
    return 'nil' if @head.nil?

    output = ''
    iterate do |node|
      node_str = "( #{node.value} )"
      output += output.empty? ? node_str : " -> #{node_str}"
    end

    output
  end

  def insert_at(target_index, *values)
    raise IndexError if target_index < 0

    if target_index == 0
      @head = insert_multiple_nodes(values, @head)
      return
    end

    iterate do |node|
      if target_index == 1
        node.next = insert_multiple_nodes(values, node.next)
        break
      else
        target_index -= 1
      end
    end

    raise IndexError if target_index > 1
  end

  def remove_at(target_index)
    raise IndexError if target_index < 0 || @head.nil?

    if target_index == 0
      @head = @head.next
      return
    end

    iterate do |node|
      if target_index == 1
        raise IndexError if node.next.nil?

        node.next = node.next.next
        break
      else
        target_index -= 1
      end
    end

    raise IndexError if target_index > 1
  end

  private

  def iterate
    return if @head.nil?

    current = @head
    yield current

    while current.next
      current = current.next
      yield current
    end
  end

  def insert_multiple_nodes(values, following_node)
    values.reverse_each do |value|
      following_node = Node.new(value, following_node)
    end

    following_node
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ClassLength
