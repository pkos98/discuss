defmodule Discuss.Topic do
  use Discuss.Web, :model

  # assign the database-table "topics" to this model
  schema "topics" do
    field :title, :string
  end

end
