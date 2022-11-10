defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.{UserView, ClockView, TeamView, WorkingTimeView}
  alias TimeManager.Repo

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "users.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("users.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      status: user.status
    }
  end

  def render("user.json", %{user: user}) do
    user = Repo.preload(user, [:clocks, :leads, :teams, :workingtimes])
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      status: user.status,
      clocks: render_many(user.clocks, ClockView, "clocks.json"),
      leads: render_many(user.leads, TeamView, "teams.json"),
      teams: render_many(user.teams, TeamView, "teams.json"),
      workingtimes: render_many(user.workingtimes, WorkingTimeView, "working_times.json")
    }
  end
end
