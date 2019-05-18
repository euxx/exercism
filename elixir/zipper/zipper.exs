defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """

  @type t :: %BinTree{value: any, left: t() | nil, right: t() | nil}
  defstruct [:value, :left, :right]
end

defimpl Inspect, for: BinTree do
  import Inspect.Algebra

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BinTree[value: 3, left: BinTree[value: 5, right: BinTree[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: value, left: left, right: right}, opts) do
    concat([
      "(",
      to_doc(value, opts),
      ":",
      if(left, do: to_doc(left, opts), else: ""),
      ":",
      if(right, do: to_doc(right, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  defstruct [:trail, :tree]
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %Zipper{trail: [], tree: bin_tree}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{tree: tree}), do: tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{trail: trail, tree: tree}) do
    keys = set_keys(trail ++ [:value])
    get_in(tree, keys)
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(ZipperZipper.t()) :: Zipper.t() | nil
  def left(zipper), do: child(zipper, :left)

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper), do: child(zipper, :right)

  defp child(%Zipper{trail: trail, tree: tree} = zipper, key) do
    keys = trail ++ [key]
    if get_in(tree, set_keys(keys)) do
      Map.put(zipper, :trail, keys)
    else
      nil
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{trail: []}), do: nil

  def up(%Zipper{trail: trail} = zipper) do
    parent_trail = trail |> Enum.reverse() |> tl() |> Enum.reverse()
    Map.put(zipper, :trail, parent_trail)
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value), do: set_value(zipper, :value, value)

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, value), do: set_value(zipper, :left, value)

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, value), do: set_value(zipper, :right, value)

  defp set_value(%Zipper{trail: trail} = zipper, key, value) do
    keys = set_keys([:tree] ++ trail ++ [key])
    put_in(zipper, keys, value)
  end

  defp set_keys(keys) do
    Enum.map(keys, &Access.key/1)
  end
end
