defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    roman_symbol = [
      {"M", 1000}, {"CM", 900}, {"D", 500}, {"CD", 400},
      {"C", 100}, {"XC", 90}, {"L", 50}, {"XL", 40},
      {"X", 10}, {"IX", 9}, {"V", 5}, {"IV", 4}, {"I", 1}
    ]
    {0, result} = Enum.reduce(roman_symbol, {number, ""}, fn {symbol, value}, {number, result} ->
      result = result <> String.duplicate(symbol, div(number, value))
      number = rem(number, value)
      {number, result}
    end)
    result
  end
end

IO.puts("Result is: #{inspect RomanNumerals.numeral(3549)}")
IO.puts("Result is: #{inspect RomanNumerals.numeral(10)}")
