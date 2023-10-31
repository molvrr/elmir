defmodule Elmir.Repo.Migrations.CreateComics do
  use Ecto.Migration

  def change do
    create table(:comics) do
      add :title, :string
      add :cover, :string

      timestamps(type: :utc_datetime)
    end
  end
end
