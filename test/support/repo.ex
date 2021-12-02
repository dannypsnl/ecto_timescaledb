defmodule Test.Repo do
  use Ecto.Repo,
    otp_app: :ecto_timescaledb,
    adapter: Ecto.Adapters.Postgres
end
