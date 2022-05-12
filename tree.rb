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

  def insert(root, data)
    return Node.new(data: data) unless root
    return root if root.data == data

    if root.data < data
      root.right = insert(root.right, data)
    else
      root.left = insert(root.left, data)
    end
    root
  end

  def delete(root, data)
    return unless root.is_a?(Node)

    # Look in left subtree if the node to be deleted is smaller than root
    if data < root.data
      root.left = delete(root.left, data) 
    # Look in right subtree if the node to be deleted is greater than root
    elsif data > root.data
      root.right = delete(root.right, data)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      temp = min_value(root.right)
      root.data = temp.data
      root.right = delete(root.right, temp.data)
    end
    root
  end

  def min_value(root)
    return unless root.is_a?(Node)
    return root unless root.left

    min_value(root.left)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
