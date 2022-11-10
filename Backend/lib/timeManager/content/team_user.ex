defmodule TimeManager.Content.TeamUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Content.{User, Team, TeamUser}

  schema "teamusers" do
    belongs_to(:user, User)
    belongs_to(:team, Team)

    timestamps()
  end

  def changeset(%TeamUser{} = teamuser, attrs) do
    teamuser
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
    |> unique_constraint([:user_id, :team_id])
  end
end
