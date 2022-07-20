defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    hours = Integer.floor_div(hour * 60 + minute, 60)
    |> Integer.mod(24)

    minutes = Integer.mod(minute, 60)

    %Clock{
      hour: hours,
      minute: minutes
    }
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end

  # Implement protocol to_string
  defimpl String.Chars, for: Clock do
    def to_string(clock) do
      [clock.hour, clock.minute]
      |> Enum.map(fn val ->
        String.pad_leading("#{val}", 2, "0")
      end)
      |> Enum.join(":")
    end
  end
end
IO.inspect(Clock.new(10, 0) |> Clock.add(3) |> to_string)
