# frozen_string_literal: true

require_relative 'node'

# allows creation, search, and modification of linked lists in Ruby
class LinkedList
  attr_accessor :name
  attr_reader :size, :head, :tail

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    temp = create_node(value)
    temp.index = @size - 1
    if @tail.nil?
      @tail = temp
      @head = @tail
    else
      @tail.next_node = temp
      @tail = temp
    end
  end

  def prepend(value)
    temp = create_node(value)
    if @head.nil?
      @head = temp
      @tail = @head
    else
      shift_indicies(0)
      temp.next_node = @head
      @head = temp
    end
  end

  def create_node(value)
    @size += 1
    Node.new(value)
  end

  def at(index)
    result = nil
    each_node do |node|
      next unless node.index == index

      result = node
    end
    result
  end

  def pop
    temp = @tail
    new_tail = at(temp.index - 1)
    @tail = new_tail
    @tail.next_node = nil
    @size -= 1
    temp
  end

  def contains?(value)
    result = false
    each_node do |node|
      next unless node.value == value

      result = true
    end
    result
  end

  def find(value)
    return nil unless contains?(value)

    each_node do |node|
      return node.index if node.value == value
    end
  end

  def to_s
    str = ''
    each_node do |node|
      str += "( #{node.value} ) -> "
    end
    str += 'nil'
  end

  def insert_at(value, index)
    shift_indicies(index)
    temp = create_node(value)
    temp.index = index
    change_next(temp, index)
    temp
  end

  def remove_at(index)
    temp = at(index)
    parent_node = at(index - 1)
    child_node = at(index + 1)
    parent_node.nil? ? @head = child_node : parent_node.next_node = child_node
    @tail = parent_node if child_node.nil?
    decrement_indicies(index)
    @size -= 1
    temp
  end

  def change_next(node, index)
    node.next_node = at(index + 1)
    if index.zero?
      @head = node
    else
      parent_node = at(index - 1)
      parent_node.next_node = node
    end
    @tail = node if node.next_node.nil?
  end

  def shift_indicies(index)
    each_node do |node|
      next if new?(node)

      node.index += 1 if node.index >= index
    end
  end

  def decrement_indicies(index)
    each_node do |node|
      next if new?(node)

      node.index -= 1 if node.index >= index
    end
  end

  def new?(node)
    if node.index.zero? && !node.equal?(@head) || node.next_node.nil? && !node.equal?(@tail)
      true
    else
      false
    end
  end

  def each_node
    return nil if @head.nil?

    node = @head
    until node.nil?
      yield node
      node = node.next_node
    end
  end
end
