# by convention: singular form (not topics)
defmodule Discuss.TopicController do
  # elixir-way of code-sharing: importing functions defined (also imported) in Discuss.Web.controller/0
  # equivalent of OOP inheritance
  use Discuss.Web, :controller
  alias Discuss.Topic # instead Discuss.Topic.changeset use Topic.changeset

  def new(conn, params) do
    struct = %Discuss.Topic{}
    change = struct
             |> Topic.changeset(params)
    render(conn, "new.html", changeset: change)
  end

  def create(conn, %{"topic" => topic}) do
    IO.inspect(topic)
  end

end
