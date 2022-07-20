defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0}) do
    helper_create(direction, position)
  end
  defp helper_create(direction, _p) when direction not in [:north, :east, :south, :west], do: {:error, "invalid direction" }
  defp helper_create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end
  defp helper_create(_d, _), do: {:error, "invalid position" }

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate({:error, msg}, _instructions) do
    {:error, msg}
  end
  def simulate(robot, instructions) when is_binary(instructions) do
    instructions = String.split(instructions, "", trim: true)
    validation = Enum.any?(instructions, fn cur_instruction -> cur_instruction not in ["R", "L", "A"] end)
    if validation do
      {:error, "invalid instruction"}
    else
      helper_move(robot, instructions)
    end
  end

  defp helper_move(robot, instructions) do
    Enum.reduce(instructions, robot, fn instruction, %{direction: direction, position: position} ->
      if instruction == "A" do
        %{direction: direction, position: advance(direction, position)}
      else
        %{direction: turning(direction, instruction), position: position}
      end
    end)
  end

  defp turning(cur_direction, instruction) do
    %{
      :north => %{"L" => :west, "R" => :east},
      :west => %{"L" => :south, "R" => :north},
      :south => %{"L" => :east, "R" => :west},
      :east => %{"L" => :north, "R" => :south}
    }
    |> Kernel.get_in([cur_direction, instruction])
  end

  defp advance(direction, position) do
    {x, y} = position

    case direction do
      :north ->
        {x, y + 1}
      :west ->
        {x - 1, y}
      :south ->
        {x, y - 1}
      :east ->
        {x + 1, y}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot[:position]
  end
end

IO.inspect(RobotSimulator.create()|> RobotSimulator.simulate("AR"))
IO.inspect(RobotSimulator.create(:invalid, {0, 0}))
IO.inspect(RobotSimulator.create(0, {0, 0}))
IO.inspect(RobotSimulator.create(:north, {0, 0, 0}))
