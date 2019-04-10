defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @valid_directions [:north, :east, :south, :west]
  @spec create(direction :: atom, position :: {integer, integer}) :: any

  def create(direction \\ :north, position \\ {0, 0})
  def create(direction,  {x, y} = position)
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
  def simulate(robot, instructions) do
    do_simulate(robot, String.split(instructions, "", trim: true))
  end

  defp do_simulate(robot, []), do: robot

  defp do_simulate(robot, ["A" | t]) do
    {x, y} = position(robot)
    robot =
      case direction(robot) do
        :north -> %{robot | position: {x, y + 1}}
        :east  -> %{robot | position: {x + 1, y}}
        :south -> %{robot | position: {x, y - 1}}
        :west  -> %{robot | position: {x - 1, y}}
      end

    do_simulate(robot, t)
  end

  defp do_simulate(robot, ["L" | t]) do
    robot =
      case direction(robot) do
        :north -> %{robot | direction: :west}
        :east  -> %{robot | direction: :north}
        :south -> %{robot | direction: :east}
        :west  -> %{robot | direction: :south}
      end

    do_simulate(robot, t)
  end

  defp do_simulate(robot, ["R" | t]) do
    robot =
      case direction(robot) do
        :north -> %{robot | direction: :east}
        :east  -> %{robot | direction: :south}
        :south -> %{robot | direction: :west}
        :west  -> %{robot | direction: :north}
      end

    do_simulate(robot, t)
  end

  defp do_simulate(_, _), do: {:error, "invalid instruction"}

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
