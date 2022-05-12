# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'

puts 'dependencies loaded!'
array = []
15.times { array.push(rand(25) + 1) }
tree = Tree.new(array)
tree.pretty_print

#tree.insert(tree.root, 5)
#tree.insert(tree.root, 9)
#tree.insert(tree.root, 42)

#p tree.min_value(tree.root.right)
tree.delete(tree.root, array[2])
tree.pretty_print
