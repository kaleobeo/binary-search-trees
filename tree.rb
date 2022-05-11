# frozen_string_literal: true

class Tree
  attr_accessor :root

  def initialize(array)
    self.root = build_tree(array)
  end

  def build_tree(array)
    return nil if !array.is_a?(Array) || array.length.zero?

    array = array.sort.uniq
    midpoint = array.length / 2
    root = Node.new(data: array[midpoint])
    root.left = build_tree(array[0...midpoint])
    root.right = build_tree(array[midpoint + 1..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
