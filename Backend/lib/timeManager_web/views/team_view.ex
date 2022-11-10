defmodule TimeManagerWeb.TeamView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.{TeamView, UserView}
  alias TimeManager.Repo

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("teams.json", %{team: team}) do
    team = Repo.preload(team, [:users])
    %{
      id: team.id,
      title: team.title,
      leader_id: team.user_id,
      users: render_many(team.users, UserView, "users.json")
    }
  end

  def render("team.json", %{team: team}) do
    team = Repo.preload(team, [:user, :users])
    %{
      id: team.id,
      title: team.title,
      leader: render_one(team.user, UserView, "users.json"),
      users: render_many(team.users, UserView, "users.json")
    }
  end
end
