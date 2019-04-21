defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> parse_emphasis_tags()
    |> wrap_ul_tag()
  end

  defp process("#" <> text), do: parse_header(text, 1)
  defp process("* " <> text), do: "<li>#{text}</li>"
  defp process(line), do: "<p>#{line}</p>"

  defp parse_header(" " <> text, level), do: "<h#{level}>#{text}</h#{level}>"
  defp parse_header("#" <> text, level), do: parse_header(text, level + 1)

  defp parse_emphasis_tags(text) do
    text
    |> String.replace( ~r/__([^_]+)__/, "<strong>\\1</strong>")
    |> String.replace( ~r/_([^_]+)_/, "<em>\\1</em>")
  end

  defp wrap_ul_tag(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
