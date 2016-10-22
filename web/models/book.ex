defmodule Bbb.Book do
  use Bbb.Web, :model

  schema "books" do
    field :title, :string
    field :author, :string
    field :edition, :integer
    field :price, :integer
    field :description, :string
    field :contact, :string
    field :topic, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :author, :edition, :price, :description, :contact])
    |> validate_required([:title, :author, :edition, :price, :description, :contact])
  end
end
