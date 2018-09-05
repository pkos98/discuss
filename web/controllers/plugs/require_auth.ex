defmodule Discuss.Plugs.RequireAuthPlug do

  import Plug.Conn
  import Phoenix.Controller
  alias Discuss.Router.Helpers

  defp get_user(%Plug.Conn{assigns: %{user: user}}), do: user

  def init(_conn) do

  end
  def init(_conn, _options) do
  end

  def call(conn, _opts = nil) do
    user = get_user(conn)
    if user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end

end
