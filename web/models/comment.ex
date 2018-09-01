defmodule Discuss.Comment do
  use Discuss.Web, :model

  # instruct the poison library to only encode the :content field to json
  @derive {Poison.Encoder, only: [:content]}

  schema "comments" do
    field :content, :string
    belongs_to :topic, Discuss.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
    |> validate_length(:content, min: 5)
  end

end
