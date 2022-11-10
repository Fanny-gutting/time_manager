defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller
  import Ecto.Query

  alias TimeManager.Content
  alias TimeManager.Content.WorkingTime
  alias TimeManager.Repo

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"id" => id, "start" => start, "end" => endd}) do
    working_time = Repo.all(from w in WorkingTime, where: w.user_id == ^id and w.start > ^start and w.end < ^endd)
    render(conn, "index.json", workingtimes: working_time)
  end

  def index(conn, _params) do
    workingtimes = Content.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"user_id" => user_id, "working_time" => %{"end" => endd, "start" => start} }) do
    with {:ok, %WorkingTime{} = working_time} <- Content.create_working_time(%{start: start, end: endd, user_id: user_id}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    working_time = Repo.get_by(WorkingTime, [id: id, user_id: user_id])
    render(conn, "show.json", working_time: working_time)
  end

  def show(conn, %{"id" => id}) do
    working_time = Content.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Content.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- Content.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Content.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Content.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
