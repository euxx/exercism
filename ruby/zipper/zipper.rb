class Zipper
  def self.from_tree(tree)
    new(tree)
  end

  attr_accessor :tree, :path

  def initialize(tree)
    @tree = tree
    @path = []
  end

  def to_tree
    @tree
  end

  def value
    focus.value
  end

  def left
    @path << :left && focus && self
  end

  def right
    @path << :right && focus && self
  end

  def up
    @path.pop && self
  end

  def set_value(value)
    focus.value = value
    self
  end

  def set_left(value)
    focus.left = value
    self
  end

  def set_right(value)
    focus.right = value
    self
  end

  def ==(zipper)
    tree == zipper.tree && path == zipper.path
  end

  private

  def focus
    @path.reduce(@tree) { |tree, key| tree.send(key) }
  end
end

class Node
  attr_accessor :value, :left, :right

  def initialize(value, left, right)
    @value, @left, @right = value, left, right
  end

  def ==(node)
    value == node.value && left == node.left && right == node.right
  end
end
