defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.Comment
  alias Discuss.Topic

  def join(name, _params, socket) do
    topic_id = name
               |> String.split(":")
               |> List.last()
    topic = Topic
            |> Repo.get!(topic_id)
            |> Repo.preload(:comments) # Load all associated comments of this topic

    IO.inspect(topic)
    # Transfer the list of comments to the client (could have also pre-rendered it in the template)
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => comment_content}, socket) do
    topic = socket.assigns.topic
    changeset = topic
                |> build_assoc(:comments) # creates a comment which references this topic
                |> Comment.changeset(%{content: comment_content})
    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}


    end
  end

end
