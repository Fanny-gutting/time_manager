defmodule TimeManagerWeb.WorkingTimeView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.{WorkingTimeView, UserView}
  alias TimeManager.Repo

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingTimeView, "working_times.json")}
  end

  def render("show.json", %{working_time: working_time}) do
    %{data: render_one(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("working_times.json", %{working_time: working_time}) do
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      user_id: working_time.user_id
    }
  end

  def render("working_time.json", %{working_time: working_time}) do
    working_time = Repo.preload(working_time, [:user])
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      user: render_one(working_time.user, UserView, "users.json")
    }
  end
end
