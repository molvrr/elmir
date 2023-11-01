defmodule ElmirWeb.ComicsController do
  use ElmirWeb, :controller

  alias Elmir.{Comic, Repo}

  def index(conn, _params) do
    comics = Repo.all(Comic) |> Enum.map(fn %Comic{ title: title, cover: cover } -> %{ title: title, cover: cover } end)

    json(conn, comics)
  end
end
