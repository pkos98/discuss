# by convention: singular form (not topics)
defmodule Discuss.TopicController do
  # elixir-way of code-sharing: importing functions defined (also imported) in Discuss.Web.controller/0
  # equivalent of OOP inheritance
  use Discuss.Web, :controller
  alias Discuss.Topic # instead Discuss.Topic.changeset use Topic.changeset

  def index(conn, _params) do
    all_topics = Repo.all(Topic)
    conn
    |> render("index.html", topics: all_topics)
  end

  def new(conn, params) do
    struct = %Discuss.Topic{}
    change = struct
             |> Topic.changeset(params)
    render(conn, "new.html", changeset: change)
  end

  def create(conn, %{"topic" => topic}) do
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

  def edit(conn, %{"id" => id}) do
    query = from t in Topic, where: t.id == ^id, select: t
    topic_to_edit = Repo.all(query)
                    |> List.first()
    conn
    |> render("edit.html", topic: topic_to_edit)
  end

end
