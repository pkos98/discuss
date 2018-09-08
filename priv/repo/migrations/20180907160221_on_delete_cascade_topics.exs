defmodule Discuss.Repo.Migrations.OnDeleteCascadeTopics do
  use Ecto.Migration

  def change do
    drop(constraint(:topics, "topics_user_id_fkey"))
    alter table(:topics) do
      modify :user_id, references(:users, on_delete: :delete_all), null: true
    end
  end
end
