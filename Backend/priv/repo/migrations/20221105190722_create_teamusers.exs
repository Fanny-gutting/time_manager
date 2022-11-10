defmodule TimeManager.Repo.Migrations.CreateTeamusers do
  use Ecto.Migration

  def change do
    create table(:teamusers) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :team_id, references(:teams, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:teamusers, [:user_id, :team_id])
    create index(:teamusers, [:user_id])
    create index(:teamusers, [:team_id])
  end
end
