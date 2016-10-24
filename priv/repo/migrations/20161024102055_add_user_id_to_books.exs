defmodule Bbb.Repo.Migrations.AddUserIdToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :user_id, references(:users)
    end
    create index(:books, [:user_id])
  end
end
