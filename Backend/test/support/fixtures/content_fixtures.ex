defmodule TimeManager.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Content` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        status: 42,
        username: "some username"
      })
      |> TimeManager.Content.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-11-04 19:03:00]
      })
      |> TimeManager.Content.create_clock()

    clock
  end

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-11-04 19:05:00],
        start: ~N[2022-11-04 19:05:00]
      })
      |> TimeManager.Content.create_working_time()

    working_time
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> TimeManager.Content.create_team()

    team
  end

  @doc """
  Generate a team_user.
  """
  def team_user_fixture(attrs \\ %{}) do
    {:ok, team_user} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.Content.create_team_user()

    team_user
  end
end
