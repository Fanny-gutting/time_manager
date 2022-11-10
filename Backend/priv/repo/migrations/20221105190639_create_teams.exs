defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :title, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:teams, [:title])
    create index(:teams, [:user_id])
  end
end
