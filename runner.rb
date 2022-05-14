# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'

puts 'dependencies loaded!'
array = [1, 2, 3, 4, 5, 7, 8, 9, 10, 12, 17, 24]
# 15.times { array.push(rand(25) + 1) }
tree = Tree.new(array)
tree.pretty_print

#tree.insert(tree.root, 5)
#tree.insert(tree.root, 9)
#tree.insert(tree.root, 42)

#p tree.min_value(tree.root.right)
#tree.delete(tree.root, array[2])
#tree.pretty_print

#p tree.find(tree.root, 7)

#test_proc = proc { |node| p node.data }

#tree.level_order(tree.root, &test_proc)

#p tree.level_order_rec([tree.root])

#p tree.inorder(tree.root)

#tree.inorder(tree.root, &test_proc)

#tree.preorder(tree.root, &test_proc)

#p tree.preorder(tree.root)

#tree.postorder(tree.root, &test_proc)

#p tree.postorder(tree.root)

#p ( tree.root.children.map(&:data))

#p tree.height(tree.root.left)

#p tree.height(tree.root)

p tree.depth(tree.root.left.right)
p tree.depth(tree.root.right.right.left)