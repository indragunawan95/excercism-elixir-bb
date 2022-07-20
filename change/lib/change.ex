defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, target) when target < 0, do: {:error, "cannot change"}
  def generate(_coins, 0), do: {:ok, []}
  def generate(coins, target) do
    changes = 1..target
    |> Enum.reduce(%{0 => []}, fn x, acc ->
      changes_cache(x, acc, coins)
    end)

    case Map.get(changes, target) do
      nil    -> {:error, "cannot change"}
      change -> {:ok, change}
    end
  end
  defp changes_cache(target, acc, coins) do
    change = coins
      |> Enum.filter(fn coin ->
        acc[target - coin]
      end)
      |> Enum.map(fn coin -> [coin | acc[target - coin]] end)
      |> Enum.min_by(fn c -> length(c) end, fn -> nil end)
    Map.put(acc, target, change)
  end
end
