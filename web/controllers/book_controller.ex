defmodule Bbb.BookController do
  use Bbb.Web, :controller

  alias Bbb.Book
  alias Bbb.User

  plug :authorize_user

  def index(conn, _params) do
    books = Enum.reverse Repo.all(Book)
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Book.changeset(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    changeset = Repo.get(User, current_user(conn).id)
    |> build_assoc(:books)
    |> Book.changeset(book_params)

    case Repo.insert(changeset) do
      {:ok, _book} ->
        conn
        |> put_flash(:info, "Buch erfolgreich hinzugefügt.")
        |> redirect(to: book_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Repo.get!(Book, id) |> Repo.preload(:user)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book)
    if current_user(conn).id == book.user_id do
      render(conn, "edit.html", book: book, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Das ist nicht dein Buch!")
      |> redirect(to: book_path(conn, :show, book))
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Buch erfolgreich bearbeitet!")
        |> redirect(to: book_path(conn, :show, book))
      {:error, changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    if current_user(conn).id == book.user_id do
      Repo.delete!(book)
      conn
      |> put_flash(:info, "Book deleted successfully.")
      |> redirect(to: book_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Das ist nicht dein Buch")
      |> redirect(to: book_path(conn, :show, book))
    end


  end

  defp authorize_user(conn, _opts) do
    if user = current_user(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Nicht authorisiert!")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

  defp current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

end
