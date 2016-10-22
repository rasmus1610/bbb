defmodule Bbb.BookTest do
  use Bbb.ModelCase

  alias Bbb.Book

  @valid_attrs %{author: "some content", contact: "some content", description: "some content", edition: "some content", price: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
