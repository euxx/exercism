class ResistorColorDuo
  class << self
    def value(colors)
      value_of(colors[0]) * 10 + value_of(colors[1])
    end

    private

    def value_of(color)
      {
        black: 0,
        brown: 1,
        red: 2,
        orange: 3,
        yellow: 4,
        green: 5,
        blue: 6,
        violet: 7,
        grey: 8,
        white: 9
      }[color.to_sym]
    end
  end
end
