defmodule Bbb.PageController do
  use Bbb.Web, :controller

  def index(conn, _params) do
    if current_user(conn) do
      conn |> redirect(to: book_path(conn, :index))
    else
      render conn, "index.html"
    end
  end

  defp current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
