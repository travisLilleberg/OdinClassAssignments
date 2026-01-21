# frozen_string_literal: true

# A Queue DS implementation using a linked list.
class Queue
  # The class for individual nodes in the Queue.
  class Node
    attr_accessor :val, :next

    def initialize(value, nxt = nil)
      @val = value
      @next = nxt
    end
  end

  def initialize
    @root = nil
  end

  def enqueue(val)
    if @root.nil?
      @root = Node.new(val)
    else
      go_to_rear.next = Node.new(val)
    end
  end

  def dequeue
    return 'Empty' if @root.nil?

    val = @root.val
    @root = @root.next
    val
  end

  def front
    return 'Empty' if @root.nil?

    @root.val
  end

  def rear
    return 'Empty' if @root.nil?

    go_to_rear.val
  end

  def empty?
    @root.nil?
  end

  def size
    count = 0
    go_to_rear { count += 1 }
    count
  end

  def show
    return 'Empty' if @root.nil?

    puts "\n-=-=-Full Queue-=-=-"
    go_to_rear { |val| p val }
    puts "\n"
  end

  private

  def go_to_rear
    return @root if @root.nil?

    current = @root
    yield current.val if block_given?

    while current.next
      current = current.next
      yield current.val if block_given?
    end

    current
  end
end

q = Queue.new
p q.empty?
puts "Current Size: #{q.size}"
q.enqueue(3)
q.enqueue(8)
q.enqueue(31)
puts "Current Size: #{q.size}"
q.show
p q.empty?
p q.front
p q.rear
p q.dequeue
puts "Current Size: #{q.size}"
q.show
p q.empty?
p q.front
p q.rear
p q.dequeue
puts "Current Size: #{q.size}"
q.show
p q.empty?
p q.front
p q.rear
p q.dequeue
puts "Current Size: #{q.size}"
q.show
p q.empty?
puts q.dequeue
puts q.front
puts q.rear
