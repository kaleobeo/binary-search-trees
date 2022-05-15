# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'


tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Is tree balanced? #{tree.balanced?}"

sleep 2.0
puts 'Level order traversal:'
p tree.level_order(tree.root)

sleep 2.0
puts 'Inorder traversal:'
p tree.inorder(tree.root)

sleep 2.0
puts 'Preorder traversal:'
p tree.preorder(tree.root)

sleep 2.0
puts 'Postorder traversal:'
p tree.postorder(tree.root)

sleep 2.0
puts 'Unbalancing tree:'
sleep 1.5
5.times { tree.insert(tree.root, rand(100..150)) }
tree.pretty_print
puts "Is tree balanced? #{tree.balanced?}"

sleep 3.0
puts 'Rebalancing tree...'
sleep 1.5
tree.rebalance
tree.pretty_print
puts "Is tree balanced? #{tree.balanced?}"

sleep 2.0
puts 'Level order traversal:'
p tree.level_order(tree.root)

sleep 2.0
puts 'Inorder traversal:'
p tree.inorder(tree.root)

sleep 2.0
puts 'Preorder traversal:'
p tree.preorder(tree.root)

sleep 2.0
puts 'Postorder traversal:'
p tree.postorder(tree.root)
