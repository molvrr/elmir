defmodule Elmir.Repo do
  use Ecto.Repo,
    otp_app: :elmir,
    adapter: Ecto.Adapters.SQLite3
end
