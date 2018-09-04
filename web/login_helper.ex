defmodule Discuss.AuthHelper do
  use Discuss.Web, :controller

  def get_user(conn = %Plug.Conn{assigns: %{user: user}}), do: user

  def is_logged_in?(conn) do
    user = get_user(conn)
    user != nil
  end

  def is_logged_in!(conn = %Plug.Conn{assigns: %{user: user}}) do
    case is_logged_in?(conn) do
      true -> user
      false -> 
        conn |> redirect_unauthorized()
    end
  end
  
  def has_access_to_model?(conn, model) do
    is_signed = conn |> is_logged_in?()
    cond  do
      is_signed && get_user(conn).id == model.user_id -> true
      true -> false
    end
  end

  def has_access_to_model!(conn, model) do
    if has_access_to_model?(conn, model) do
      get_user(conn)
    else
      conn |> redirect_unauthorized()
    end
  end

  defp redirect_unauthorized(conn) do
    conn
    |> put_flash(:error, "You are not authorized to perform this action!")
    |> redirect(to: topic_path(conn, :index))
  end

end