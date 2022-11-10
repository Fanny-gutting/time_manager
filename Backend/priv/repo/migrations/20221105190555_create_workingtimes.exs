defmodule TimeManager.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:workingtimes, [:start, :end, :user_id])
    create index(:workingtimes, [:start, :end])
    create index(:workingtimes, [:user_id])
  end
end
