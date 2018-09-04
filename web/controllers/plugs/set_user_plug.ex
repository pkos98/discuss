defmodule Discuss.Plugs.SetUserPlug do
  import Plug.Conn
  alias Discuss.Repo
  alias Discuss.User

  def init(options), do: options
  

  def call(conn, _options) do
    user_id = get_session(conn, :user_id)
    cond do
      user = user_id && Repo.get(User, user_id) -> # if both != nil the &&-expression returns the latter (the user struct)
        conn |> assign(:user, user)
      true -> 
        conn |> assign(:user, nil)
    end
  end

end