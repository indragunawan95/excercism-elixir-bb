defmodule Bob do
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

IO.puts("Result is: #{inspect Bob.hey("WATCH OUT!")}")
IO.puts("Result is: #{inspect Bob.hey("hello")}")
IO.puts("Result is: #{inspect Bob.hey("How are you?")}")
