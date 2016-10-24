defmodule Bbb.SessionController do
  use Bbb.Web, :controller
  alias Bbb.User
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) when not is_nil(email) and not is_nil(password) do
    Repo.get_by(User, email: email)
    |> sign_in(password, conn)
  end

  def create(conn, _) do
    failed_login(conn)
  end

  def delete(conn, _params) do
    conn
      |> delete_session(:current_user)
      |> put_flash(:info, "Ausgeloggt!")
      |> redirect(to: book_path(conn, :index))
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
       |> failed_login
  end

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_digest) do
      conn
        |> put_session(:current_user, %{id: user.id, email: user.email})
        |> put_flash(:info, "Erfolgreich eingeloggt!!")
        |> redirect(to: book_path(conn, :index))
    else
      conn
        |> failed_login
    end
  end

  defp failed_login(conn) do
    dummy_checkpw()
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Ungültige Email/Passwort-Kombination")
    |> redirect(to: session_path(conn, :new))
    |> halt()
  end
end
