# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'

puts 'dependencies loaded!'

tree = Tree.new([1, 7, 4, 3, 10, 15, 2, 17])
tree.pretty_print
