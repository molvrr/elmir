defmodule ElmirWeb.UsersController do
  use ElmirWeb, :controller

  def index(conn, _params) do
    users = [%{name: "Naruto"}, %{name: "Rock Lee"}]

    json(conn, users)
  end
end
