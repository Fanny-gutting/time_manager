defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.{ClockView, UserView}
  alias TimeManager.Repo

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clocks.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clocks.json", %{clock: clock}) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status,
      user_id: clock.user_id
    }
  end

  def render("clock.json", %{clock: clock}) do
    clock = Repo.preload(clock, [:user])
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status,
      user: render_one(clock.user, UserView, "users.json")
    }
  end
end
