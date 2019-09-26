defmodule TodoWeb.UserTokenPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    conn =
      case get_session(conn, :todo_token) do
        nil -> put_session(conn, :todo_token, Ecto.UUID.generate())
        _ -> conn
      end

    assign(conn, :todo_token, get_session(conn, :todo_token))
  end
end
