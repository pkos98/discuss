defmodule Discuss.Topic do
  use Discuss.Web, :model

  # assign the database-table "topics" to this model
  schema "topics" do
    field :title, :string
    field :content, :string
    has_many :comments, Discuss.Comment
    belongs_to :user, Discuss.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content]) # creates a changeset (updating the struct with the permitted field)
    |> validate_required([:title, :content]) # make title a required field (not allowed to be empty)
    |> validate_length(:title, min: 3)
    |> validate_length(:content, min: 3)
  end

end
