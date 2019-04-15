class Robot
  DIRECTIONS = [:north, :east, :south, :west]

  attr_accessor :index, :x, :y

  def orient(direction)
    raise ArgumentError unless  DIRECTIONS.include?(direction)
    @index = DIRECTIONS.index(direction)
  end

  def bearing
    DIRECTIONS[@index % 4]
  end

  def turn_left
    @index -= 1
  end

  def turn_right
    @index += 1
  end

  def at(x, y)
    @x, @y = x, y
  end

  def coordinates
    [@x, @y]
  end

  def advance
    case bearing
    when :east
      @x += 1
    when :south
      @y -= 1
    when :west
      @x -= 1
    when :north
      @y += 1
    end
  end
end

class Simulator
  INSTRUCTIONS = {"L" => :turn_left, "R" => :turn_right, "A" => :advance}

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, string)
    instructions(string).each { |instruction| robot.send(instruction) }
  end

  def instructions(string)
    string.chars.map { |letter| INSTRUCTIONS[letter] }
  end
end
