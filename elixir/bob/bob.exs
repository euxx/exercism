import String

defmodule Bob do
  def hey(input) do
    cond do
      silence?(input)           -> "Fine. Be that way!"
      forceful_question?(input) -> "Calm down, I know what I'm doing!"
      question?(input)          -> "Sure."
      shouting?(input)          -> "Whoa, chill out!"
      true                      -> "Whatever."
    end
  end

  defp silence?(input), do: trim(input) == ""

  defp forceful_question?(input), do: question?(input) && shouting?(input)

  defp question?(input), do: input |> ends_with?("?")

  defp shouting?(input), do: upcase(input) == input && upcase(input) != downcase(input)
end
