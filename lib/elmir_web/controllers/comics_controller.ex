defmodule ElmirWeb.ComicsController do
  use ElmirWeb, :controller

  def index(conn, _params) do
    users = [%{title: "Oyasumi Punpun"}, %{title: "Gash Bell!"}]

    json(conn, users)
  end
end
