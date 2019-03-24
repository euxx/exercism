defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: do_count(l, 0)

  defp do_count([], value), do: value
  defp do_count([_ | t], value), do: do_count(t, value + 1)

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l, [])

  defp do_reverse([], l), do: l
  defp do_reverse([h | t], l), do: do_reverse(t, [h | l])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f, [])

  defp do_map([], _, new_l), do: reverse(new_l)
  defp do_map([h | t], f, new_l), do: do_map(t, f, [f.(h) | new_l])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f, [])

  defp do_filter([], _, new_l), do: reverse(new_l)
  defp do_filter([h | t], f, new_l), do: do_filter(t, f, f.(h) && [h | new_l] || new_l)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(reverse(a), b)

  defp do_append(a, []), do: reverse(a)
  defp do_append(a, [h | t]), do: do_append([h | a], t)

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll, []) |> reverse()

  defp do_concat([], new_l), do: new_l
  defp do_concat([h | t], new_l) when is_list(h), do: do_concat(t, do_concat(h, new_l))
  defp do_concat([h | t], new_l), do: do_concat(t, [h | new_l])
end
