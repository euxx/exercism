import String

defmodule Bob do
  def hey(input) do
    cond do
      trim(input) == "" ->
        "Fine. Be that way!"
      question?(input) && shouting?(input) ->
        "Calm down, I know what I'm doing!"
      question?(input) ->
        "Sure."
      shouting?(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  defp question?(input) do
    ends_with?(input, "?")
  end

  defp shouting?(input) do
    upcase(input) == input && upcase(input) != downcase(input)
  end
end
