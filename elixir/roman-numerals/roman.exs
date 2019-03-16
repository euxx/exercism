defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """

  @roman_base [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    to_numerals(@roman_base, number, "")
  end

  defp to_numerals([], _, romans), do: romans

  defp to_numerals([{number, letter} | remain_base], remainder, romans)
  when div(remainder, number) > 0 do
    romans = "#{romans}#{String.duplicate(letter, div(remainder, number))}"
    remainder = rem(remainder, number)
    to_numerals(remain_base, remainder, romans)
  end

  defp to_numerals([_ | remain_base], remainder, romans) do
    to_numerals(remain_base, remainder, romans)
  end
end
