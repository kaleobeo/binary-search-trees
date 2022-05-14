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
    # Else this is the node to be deleted
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      # When there is two children
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

  def find(root, data)
    return root if root.data == data || !root.is_a?(Node)

    data < root.data ? find(root.left, data) : find(root.right, data)
  end

  def level_order(root, &block)
    queue = []
    default_output = []
    queue.push(root)

    until queue.empty?
      queue += queue[0].children
      block_given? ? block.call(queue.shift) : default_output.push(queue.shift.data)
    end
    default_output unless default_output.length.zero?
  end

  def level_order_rec(queue = [], arr = [], &block)
    return if queue.empty?

    next_elem = queue[0]
    block_given? ? block.call(next_elem) : arr.push(next_elem.data)
    queue += next_elem.children
    queue.shift
    return arr if queue.empty? && !block_given?

    level_order_rec(queue, arr, &block)
  end

  def inorder(root, arr = [], &block)
    return if root.nil?

    inorder(root.left, arr, &block)
    block_given? ? block.call(root) : arr.push(root.data)
    inorder(root.right, arr, &block)
    arr unless block_given?
  end

  def preorder(root, arr = [], &block)
    return if root.nil?

    block_given? ? block.call(root) : arr.push(root.data)
    preorder(root.left, arr, &block)
    preorder(root.right, arr, &block)
    arr unless block_given?
  end

  def postorder(root, arr = [], &block)
    return if root.nil?

    preorder(root.left, arr, &block)
    preorder(root.right, arr, &block)
    block_given? ? block.call(root) : arr.push(root.data)
    arr unless block_given?
  end

  def height(node)
    return 0 
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
