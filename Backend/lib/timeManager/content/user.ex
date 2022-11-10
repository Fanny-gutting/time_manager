defmodule TimeManager.Content.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Content.{User, Team, TeamUser, Clock, WorkingTime}

  schema "users" do
    field :username, :string
    field :email, :string
    field :status, :integer
    has_many(:clocks, Clock)
    has_many(:workingtimes, WorkingTime)
    has_many(:leads, Team)
    many_to_many(:teams, Team, join_through: TeamUser)

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :status])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^[[:alnum:]]+@+[[:alnum:]]+\.+[[:alnum:]]/)
    |> unique_constraint(:email)
  end
end
