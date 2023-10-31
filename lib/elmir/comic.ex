defmodule Elmir.Comic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comics" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comic, attrs) do
    comic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
