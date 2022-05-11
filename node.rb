# frozen_string_literal: true

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data: nil, left: nil, right: nil)
    self.data = data
    self.left = left
    self.right = right
  end

  def <=>(other)
    data <=> other.data
  end
end