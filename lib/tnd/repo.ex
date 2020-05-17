defmodule Tnd.Repo do
  use Ecto.Repo,
    otp_app: :tnd,
    adapter: Ecto.Adapters.Postgres
end
