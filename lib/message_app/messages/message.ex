defmodule MessageApp.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :messageText, :string
    field :personType, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:title, :messageText, :personType])
    |> validate_required([:title, :messageText, :personType])
  end
end
