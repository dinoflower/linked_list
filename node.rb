# frozen_string_literal: true

# nodes for use in the LinkedList class
class Node
  attr_accessor :value, :next_node, :index

  def initialize(value = nil)
    @value = value
    @next_node = nil
    @index = 0
  end
end
