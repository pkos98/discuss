defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth
  alias Discuss.User

  @doc """
  Handles the callback-phase of the OAuth-process.
  During this phase the provider (github) calls this route
  and it handles the successfull or failed authentication.
  1. It looks at the result
  2. On success, it looks if the user already signed in before
     if not, the user is inserted into the DB.
  3. Put the user-id into the session-cookie to persist as "logged in" state
  4. Redirect to index
  """
  def callback(conn, %{"code" => oauth_code}) do
    auth = conn.assigns.ueberauth_auth
    user_params = %{email: auth.info.email, token: auth.credentials.token, provider: "github",
                    nickname: auth.info.nickname, avatar: auth.info.urls.avatar_url}
    changeset = %User{} |> User.changeset(user_params)
    sign_in(conn, changeset)
  end

  def sign_out(conn, user) do
    conn
    |> configure_session(drop: true)
    |> assign(:user, nil)
    |> redirect(to: topic_path(conn, :index))
  end

  defp sign_in(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back, #{User.get_name(user)}")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end



end
