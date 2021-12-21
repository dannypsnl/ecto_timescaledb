# EctoTimescaledb

[![Elixir CI](https://github.com/dannypsnl/ecto_timescaledb/actions/workflows/elixir.yml/badge.svg)](https://github.com/dannypsnl/ecto_timescaledb/actions/workflows/elixir.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/ecto_timescaledb.svg?style=flat-square)](https://hex.pm/packages/ecto_timescaledb)
[![Hex.pm](https://img.shields.io/hexpm/dt/ecto_timescaledb.svg?style=flat-square)](https://hex.pm/packages/ecto_timescaledb)

Extend `Ecto.Query` to write TimescaleDB's SQL as builtin

[Documentation](https://hexdocs.pm/ecto_timescaledb/api-reference.html)

## Installation

The package can be installed by adding `ecto_timescaledb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_timescaledb, "~> 0.9.0"}
  ]
end
```

## Quick start

Create time-series table in migration

```elixir
use Ecto.Migration.Timescaledb

def up do
  create table(:test_table, primary_key: false) do
    add :time, :naive_datetime, null: false
    add :example, :string
  end

  create_hypertable(:test_table, :time)
end

def down do
  drop(table(:test_table))
end
```

time-series query example

```elixir
import Ecto.Query
import Ecto.Query.Timescaledb

from(s in Stat,
  select: [time_bucket("7 days", time, bucket), sum(s.avg) ~> sum_avg],
  where: fragment("sum_avg") > 100,
  group_by: fragment("bucket"),
  order_by: [desc: fragment("bucket")]
)
```

