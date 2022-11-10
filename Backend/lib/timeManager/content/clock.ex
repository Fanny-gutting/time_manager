defmodule TimeManager.Content.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Content.{User, Clock}

  schema "clocks" do
    field :time, :naive_datetime
    field :status, :boolean
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(%Clock{} = clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> unique_constraint([:time, :status, :user_id])
  end
end
