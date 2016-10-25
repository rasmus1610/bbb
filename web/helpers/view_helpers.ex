defmodule Bbb.ViewHelpers do
  import Plug.Conn

  def current_user(conn) do
    get_session(conn, :current_user)
  end
end
