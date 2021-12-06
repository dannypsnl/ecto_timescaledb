use Mix.Config

config :ecto_timescaledb,
  ecto_repos: [Support.Repo]

import_config "#{Mix.env()}.exs"
