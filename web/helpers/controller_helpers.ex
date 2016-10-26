defmodule Bbb.ControllerHelpers do
  import Phoenix.Controller
  import Plug.Conn
  import Bbb.Router.Helpers

  def authorize_user(conn, _opts) do
    if current_user(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Nicht authorisiert!")
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
