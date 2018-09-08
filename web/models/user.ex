defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :nickname, :string
    field :avatar, :string
    has_many :topics, Discuss.Topic
    has_many :comments, Discuss.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token, :nickname, :avatar])
    |> validate_required([:email, :provider, :token])
  end

  def get_name(user) do
    if user.nickname, do: user.nickname, else: user.email
  end

end
