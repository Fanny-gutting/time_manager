defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Content
  alias TimeManager.Content.Team
  alias TimeManager.Repo
  import Ecto.Query

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = Content.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"user_id" => user_id, "team" => %{"title" => title}}) do
    with {:ok, %Team{} = team} <- Content.create_team(%{title: title, user_id: user_id}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Content.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Content.get_team!(id)

    with {:ok, %Team{} = team} <- Content.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Content.get_team!(id)

    with {:ok, %Team{}} <- Content.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
