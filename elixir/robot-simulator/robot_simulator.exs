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
  def simulate(robot, instructions) do
    do_simulate(robot, String.split(instructions, "", trim: true))
  end

  defp do_simulate(_, [h | _]) when not(h in ["A", "L", "R"]) do
    {:error, "invalid instruction"}
  end

  defp do_simulate(robot, []), do: robot

  defp do_simulate(robot, [h | t]) when h == "A" do
    {x, y} = position(robot)
    robot =
      case direction(robot) do
        :north -> Map.put(robot, :position, {x, y + 1})
        :east  -> Map.put(robot, :position, {x + 1, y})
        :south -> Map.put(robot, :position, {x, y - 1})
        :west  -> Map.put(robot, :position, {x - 1, y})
      end

    do_simulate(robot, t)
  end

  defp do_simulate(robot, [h | t]) when h == "L" do
    robot =
      case direction(robot) do
        :north -> Map.put(robot, :direction, :west)
        :east  -> Map.put(robot, :direction, :north)
        :south -> Map.put(robot, :direction, :east)
        :west  -> Map.put(robot, :direction, :south)
      end

    do_simulate(robot, t)
  end

  defp do_simulate(robot, [h | t]) when h == "R" do
    robot =
      case direction(robot) do
        :north -> Map.put(robot, :direction, :east)
        :east  -> Map.put(robot, :direction, :south)
        :south -> Map.put(robot, :direction, :west)
        :west  -> Map.put(robot, :direction, :north)
      end

    do_simulate(robot, t)
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
