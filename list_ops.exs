defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  def count([], counter) do
    counter
  end

  def count(list, counter) do
    [_head | tail] = list
    count(tail, counter + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  def reverse([], container) do
    container
  end

  def reverse(l, container) do
    [head | tail] = l
    reverse(tail, [head | container])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  def map([], _f, acc), do: reverse(acc)

  def map(l, f, acc) do
    [head | tail] = l
    map(tail, f, [f.(head) | acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  def filter([], _, acc), do: reverse(acc)
  def filter(l, f, acc) do
    [head | tail] = l
    if f.(head) do
      filter(tail, f, [head | acc])
    else
      filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc
  def foldl(l, acc, f) do
    [head | tail] = l
    foldl(tail, f.(head, acc), f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    helper_foldr(reverse(l), acc, f)
  end

  defp helper_foldr([], acc, _f), do: acc
  defp helper_foldr(l, acc, f) do
    [head | tail] = l
    helper_foldr(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    helper_append(reverse(a), b)
  end

  defp helper_append([], b), do: b
  defp helper_append(a, b) do
    [head | tail] = a
    helper_append(tail, [head | b])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    foldl(ll, [], &(append(&2, &1)))
  end
end

# IO.inspect(ListOps.count([4, 2, 3]))
# IO.inspect(ListOps.reverse([1, 2, 3]))
# IO.inspect(ListOps.map([1, 2, 3], fn x ->
#   if rem(x, 2) == 0 do
#     "even"
#   else
#     "odd"
#   end
# end))
# IO.inspect(ListOps.filter([1, 2, 3, 4, 5, 6], fn x ->
#   rem(x, 2) == 0
# end))
# IO.inspect(ListOps.foldl([1, 2, 3, 4, 5, 6], 0, fn x, acc ->
#   acc + x
# end))
# IO.inspect(ListOps.foldr([1, 2, 3, 4, 5, 6], [], fn x, acc ->
#   if rem(x, 2) == 0 do
#     [x | acc]
#   else
#     acc
#   end
# end))
# IO.inspect(ListOps.append([1, 2, 3], [4, 5]))
# IO.inspect(ListOps.concat([[1, 2, 3], [4, 5], [1, 1]]))

IO.inspect(ListOps.filter([true, false, nil, 0, 1, ""], & &1))
