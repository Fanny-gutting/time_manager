defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Content
  alias TimeManager.Content.User
  alias TimeManager.Repo

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username}) do
    user = Repo.get_by(User, [email: email, username: username])
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    users = Content.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Content.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def options(conn, _params) do
    conn
    |> put_status(:ok)
  end

  def show(conn, %{"id" => id}) do
    user = Content.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Content.get_user!(id)

    with {:ok, %User{} = user} <- Content.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Content.get_user!(id)

    with {:ok, %User{}} <- Content.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
