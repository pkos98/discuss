# by convention: singular form (not topics)
defmodule Discuss.TopicController do
  # elixir-way of code-sharing: importing functions defined (also imported) in Discuss.Web.controller/0
  # equivalent of OOP inheritance
  use Discuss.Web, :controller
  alias Discuss.Topic # instead Discuss.Topic.changeset use Topic.changeset
  alias Discuss.AuthHelper

  def index(conn, _params) do
    all_topics = Repo.all(Topic)
    conn
    |> render("index.html", topics: all_topics)
  end

  def new(conn = %Plug.Conn{assigns: %{user: user}}, params) do
    user = AuthHelper.is_logged_in!(conn)
    struct = %Discuss.Topic{}
    change = struct
             |> Topic.changeset(params)
    render(conn, "new.html", changeset: change)
  end

  def create(conn, %{"topic" => topic}) do
    user = AuthHelper.is_logged_in!(conn)
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, model} ->
        conn
        |> put_flash(:info, "Successfully created new topic \"#{model.title}\"")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        IO.inspect(changeset)
        changeset = %{changeset | action: :index}
        conn
        |> put_flash(:error, "An error occured!")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)
    conn
    |> render("show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic_to_edit = Discuss.Repo.get(Topic, id)
    changeset = Topic.changeset(topic_to_edit)
    conn
    |> render("edit.html", changeset: changeset, topic: topic_to_edit)
  end

  def update(conn, %{"id" => id, "topic" => changed_topic}) do
    old_topic = Repo.get(Topic, id)
    changeset = old_topic |> Topic.changeset(changed_topic)
    case Repo.update(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Sucessfully edited topic!")
        |> redirect(to: topic_path(conn, :index))
      {:error, err_changeset} ->
        conn
        |> render("edit.html", changeset: err_changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    # by using the macros (!), the user will automatically be redirected
    # to an error site (like 404) if anything goes wrong
    Repo.get!(Topic, id) |> Repo.delete!()
    conn
    |> put_flash(:info, "Successfully deleted!")
    |> redirect(to: topic_path(conn, :index))
  end

end
