defmodule Discuss.Repo.Migrations.AddTimestampsTopic do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      timestamps()
    end
  end
end
