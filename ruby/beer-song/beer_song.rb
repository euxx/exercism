class BeerSong
  class << self
    def recite(start, num)
      ((start - num + 1)..start).map(&method(:verse)).reverse.join("\n")
    end

    private

    def verse(n)
      case n
      when 0
        <<~STRING
          No more bottles of beer on the wall, no more bottles of beer.
          Go to the store and buy some more, 99 bottles of beer on the wall.
        STRING
      when 1
        <<~STRING
          1 bottle of beer on the wall, 1 bottle of beer.
          Take it down and pass it around, no more bottles of beer on the wall.
        STRING
      when 2
        <<~STRING
          2 bottles of beer on the wall, 2 bottles of beer.
          Take one down and pass it around, 1 bottle of beer on the wall.
        STRING
      else
        <<~STRING
          #{n} bottles of beer on the wall, #{n} bottles of beer.
          Take one down and pass it around, #{n - 1} bottles of beer on the wall.
        STRING
      end
    end
  end
end
