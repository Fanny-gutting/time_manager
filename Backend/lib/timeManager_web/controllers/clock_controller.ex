defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Content
  alias TimeManager.Content.Clock
  alias TimeManager.Repo
  import Ecto.Query

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Content.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"user_id" => user_id, "clock" => %{"time" => time, "status" => status}}) do
    with {:ok, %Clock{} = clock} <- Content.create_clock(%{time: time, status: status, user_id: user_id}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clocks = Repo.all(from c in Clock, where: c.user_id == ^id)
    render(conn, "index.json", clocks: clocks)
  end

  # def show(conn, %{"id" => id}) do
  #   clock = Content.get_clock!(id)
  #   render(conn, "show.json", clock: clock)
  # end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Content.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Content.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Content.get_clock!(id)

    with {:ok, %Clock{}} <- Content.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
