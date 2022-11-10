defmodule TimeManager.Content.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Content.{User, WorkingTime}

  schema "workingtimes" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(%WorkingTime{} = workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> unique_constraint([:start, :end, :user_id])
  end
end
