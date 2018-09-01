Changing the database (add a new table, alter an existing one etc...)  
is done using **migrations** which document the changes and thus (can) provide  
up/downgrading functionality (say, you want to revert an ALTER table command).  
`mix ecto.gen.migration add_comments_table` creates the migration file `add_comments_table.exs`  
```
def change do
  create table(:comments) do
      add :content, :string
      add :topic_id, references(:topics)
      timestamps()
  end
end
```
The code above creates a new table `comments` with it's content field and exposes its *one-to-many* association with the `topics` table using the foreign-key field `topic_id` and the use of `references/1`.
Use `mix ecto.migrate` to actually execute the migration.

The corresponding `Discuss.Comment` model:
```
  schema "comments" do
    field :content, :string
    belongs_to :topic, Discuss.Topic

    timestamps()
  end
```
By defining a schema, ecto automatically defines a struct with the schema fields.
