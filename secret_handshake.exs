defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    list_of_command = [{0b1, "wink"}, {0b10, "double blink"}, {0b100, "close your eyes"}, {0b1000, "jump"}]
    |> Enum.reduce([], fn {binary_literal, command}, result ->
      case code &&& binary_literal do
        0 ->
          result

        _ ->
         result ++ [command]

      end
    end)

    if (code &&& 0b10000) != 0 do
      list_of_command
      |> Enum.reverse()
    else
      list_of_command
    end
  end
end

IO.inspect(SecretHandshake.commands(3))
IO.inspect(SecretHandshake.commands(19))
