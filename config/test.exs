use Mix.Config

config :ecto_timescaledb, Support.Repo,
  database: "ecto_timescaledb",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
