defmodule Discuss.Repo.Migrations.AddUserFieldsNicknameAvatar do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :nickname, :string
      add :avatar, :string
    end
  end
end
