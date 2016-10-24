defmodule Bbb.Book do
  use Bbb.Web, :model

  schema "books" do
    field :title, :string
    field :author, :string
    field :edition, :integer
    field :price, :integer
    field :description, :string
    field :topic, :string
    belongs_to :user, Bbb.User

    timestamps()
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :author, :edition, :price, :description])
    |> validate_required([:title, :author, :edition, :price, :description])
  end
end
