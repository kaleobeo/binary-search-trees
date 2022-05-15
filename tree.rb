# frozen_string_literal: true

# Manages functions to create, add, delete, etc. from a BST
class Tree
  attr_accessor :root

  def initialize(array)
    self.root = build_tree(array)
  end

  def build_tree(array)
    return nil if !array.is_a?(Array) || array.empty?

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
      return root.children[0] if root.children.length <= 1

      # When there is two children
      delete_two_children(root)
    end
    root
  end

  def delete_two_children(root)
    temp = min_value(root.right)
    root.data = temp.data
    root.right = delete(root.right, temp.data)
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

  # Traverses the tree in breadth-first fashion

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

  def level_order_rec(root = nil, queue: [], arr: [], &block)
    queue.push(root).compact!
    return if queue.empty?

    next_elem = queue[0]
    block_given? ? block.call(next_elem) : arr.push(next_elem.data)
    queue += next_elem.children
    queue.shift
    return arr if queue.empty? && !block_given?

    level_order_rec(queue: queue, arr: arr, &block)
  end

  # yields the elements of the tree to a given block in a particular depth
  # first order, returns an array of values if no block is given

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

  # returns the height (edges between node and lowest leaf) of a given node in the tree

  def height(node)
    return 0 if node.children.length.zero? || node.nil?

    1 + node.children.map { |child| height(child) }.max
  end

  # returns the depth (distance from root to given node) of a given node in the tree
  def depth(node, root = nil)
    root ||= self.root
    return 0 if root == node
    return Float::INFINITY if root.children.empty?

    1 + root.children.map { |child| depth(node, child) }.min
  end

  # verifies that a tree is balanced (difference between children's heights is no more than 1)

  def balanced?(root = nil)
    root ||= self.root
    return true if root.children.empty?

    children_heights = root.children.map { |child| height(child) }
    [0, 1].include?(children_heights.max - children_heights.min) && root.children.all? { |child| balanced?(child) }
  end

  # traverses the tree, logging the data and using it to rebuild a balanced tree
  def rebalance
    self.root = build_tree(level_order_rec(root))
  end

  # Not written by me, but a very clever way to print a BST
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
