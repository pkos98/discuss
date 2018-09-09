defmodule Discuss.Repo.Migrations.OnDeleteCascadeCommentsTopic do
  use Ecto.Migration

  def change do
    drop(constraint(:comments, "comments_topic_id_fkey"))
    alter table(:comments) do
      modify :topic_id, references(:topics, on_delete: :delete_all), null: true
    end
  end
end
