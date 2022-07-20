defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      shout?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"
      shout?(input) ->
        "Whoa, chill out!"
      nothing?(input) ->
        "Fine. Be that way!"
      question?(input) ->
        "Sure."
      true ->
        "Whatever."
    end
  end

  defp shout?(input) do
    input == String.upcase(input) and input != String.downcase(input)
  end

  defp question?(input) do
    input
      |> String.trim()
      |> String.ends_with?("?")
  end

  defp nothing?(input) do
    input
      |> String.trim()
      |> String.length() == 0
  end
end
