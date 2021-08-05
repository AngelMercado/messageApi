defmodule MessageApp.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :title, :string, null: false
      add :messageText, :string, nul: false
      add :personType, :string, null: false

      timestamps()
    end

  end
end
