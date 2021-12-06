use Mix.Config

config :ecto_timescaledb,
  ecto_repos: [Test.Repo]

import_config "#{Mix.env()}.exs"
