defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :status, :integer, default: 3

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
