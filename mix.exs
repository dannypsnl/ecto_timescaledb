defmodule EctoTimescaledb.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_timescaledb,
      version: "0.10.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package()
    ]
  end

  defp elixirc_paths(:test), do: elixirc_paths(:dev) ++ ["test/support", "test/user_app"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    case Mix.env() do
      :prod ->
        [extra_applications: [:logger]]

      _ ->
        [
          mod: {Support.Application, []},
          extra_applications: [:logger]
        ]
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.0", only: [:dev, :test]},
      {:ecto_sql, ">= 0.0.0", only: [:dev, :test]},
      {:postgrex, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      licenses: ["BSD-3-Clause"],
      links: %{"GitHub" => "https://github.com/dannypsnl/ecto_timescaledb"}
    ]
  end

  defp description() do
    """
    Extend `Ecto.Query` to write TimescaleDB's SQL as builtin
    """
  end
end
