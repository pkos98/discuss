defmodule Discuss.Repo.Migrations.TopicsAddContentField do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :content, :string
    end
  end
end
