defmodule Discuss.Topic do
  use Discuss.Web, :model

  # assign the database-table "topics" to this model
  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title]) # creates a changeset (updating the struct with the permitted field)
    |> validate_required([:title]) # make title a required field (not allowed to be empty)
  end

end
