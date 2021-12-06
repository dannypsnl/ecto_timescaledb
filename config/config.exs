use Mix.Config

config :ecto_timescaledb, Test.Repo,
  database: "ecto_timescaledb",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

import_config "#{Mix.env()}.exs"
