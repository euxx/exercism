defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @valid_directions [:north, :east, :south, :west]
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, {x, y} = position \\ {0, 0})
  when (direction in @valid_directions) and is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end

  def create(direction, _) when direction in @valid_directions do
    {:error, "invalid position"}
  end

  def create(_, _), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(%{position: position, direction: direction}, instructions) do
    do_simulate(position, direction, String.split(instructions, "", trim: true))
  end

  defp do_simulate(_, _, [h | _]) when not(h in ["A", "L", "R"]) do
    {:error, "invalid instruction"}
  end

  defp do_simulate(position, direction, []), do: create(direction, position)

  defp do_simulate({x, y}, :north, [h | t]) do
    {direction, position} =
      case h do
        "A" -> {:north, {x, y + 1}}
        "L" -> {:west, {x, y}}
        "R" -> {:east, {x, y}}
      end

    do_simulate(position, direction, t)
  end

  defp do_simulate({x, y}, :east, [h | t]) do
    {direction, position} =
      case h do
        "A" -> {:east, {x + 1, y}}
        "L" -> {:north, {x, y}}
        "R" -> {:south, {x, y}}
      end

    do_simulate(position, direction, t)
  end

  defp do_simulate({x, y}, :south, [h | t]) do
    {direction, position} =
      case h do
        "A" -> {:south, {x, y - 1}}
        "L" -> {:east, {x, y}}
        "R" -> {:west, {x, y}}
      end

    do_simulate(position, direction, t)
  end

  defp do_simulate({x, y}, :west, [h | t]) do
    {direction, position} =
      case h do
        "A" -> {:west, {x - 1, y}}
        "L" -> {:south, {x, y}}
        "R" -> {:north, {x, y}}
      end

    do_simulate(position, direction, t)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
