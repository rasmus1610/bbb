defmodule Bbb.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :edition, :integer
      add :price, :integer
      add :description, :string
      add :topic, :string

      timestamps()
    end

  end
end
