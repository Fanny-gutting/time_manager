defmodule TimeManager.Content.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Content.{User, Team, TeamUser}

  schema "teams" do
    field :title, :string
    belongs_to(:user, User)
    many_to_many(:users, User, join_through: TeamUser)

    timestamps()
  end
  def changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
    |> unique_constraint([:title])
  end
end
