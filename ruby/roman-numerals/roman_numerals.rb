module RomanNumerals
  ROMAN_BASE = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }

  def to_roman
    remainder = self
    ROMAN_BASE.each_with_object("") do |(num, roman_literal), roman_numerals|
      roman_numerals << roman_literal * (remainder / num)
      remainder %= num
    end
  end
end

class Integer
  include RomanNumerals
end
