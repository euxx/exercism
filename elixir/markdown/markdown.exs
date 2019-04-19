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
    String.split(markdown, "\n")
    |> Enum.map_join(&process/1)
    |> wrap_ul_tag()
  end

  defp process("#" <> _ = header), do: parse_header(header)
  defp process("*" <> _ = list), do: parse_list_md_level(list)
  defp process(line), do: String.split(line) |> enclose_with_paragraph_tag()

  defp parse_header(header) do
    parse_header_md_level(header) |> enclose_with_header_tag()
  end

  defp parse_header_md_level(header) do
    [heading_signs | words] = String.split(header)
    {String.length(heading_signs) |> to_string(), Enum.join(words, " ")}
  end

  defp parse_list_md_level(list) do
    text =
      String.trim_leading(list, "* ")
      |> String.split()
      |> join_words_with_tags()
    "<li>#{text}</li>"
  end

  defp enclose_with_header_tag({level, text}) do
    "<h#{level}>#{text}</h#{level}>"
  end

  defp enclose_with_paragraph_tag(words) do
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    Enum.map_join(words, " ", &replace_md_with_tag/1)
  end

  defp replace_md_with_tag(word) do
    replace_prefix_md(word) |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    word
    |> String.replace(~r/^__/, "<strong>")
    |> String.replace(~r/^_/, "<em>")
  end

  defp replace_suffix_md(word) do
    word
    |> String.replace(~r/__/, "</strong>")
    |> String.replace(~r/_/, "</em>")
  end

  defp wrap_ul_tag(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
