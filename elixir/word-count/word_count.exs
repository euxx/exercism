defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.downcase(sentence)
    |> String.split(~r{[,:!&@$%^_ ]+})
    |> Enum.reduce(%{}, &count_word(&1, &2))
  end

  defp count_word("", acc), do: acc
  defp count_word(word, acc) do
    count = if acc[word], do: acc[word] + 1, else: 1
    Map.update(acc, word, count, &(&1 + 1))
  end
end
