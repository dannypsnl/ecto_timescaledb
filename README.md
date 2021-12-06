# EctoTimescaledb

[![Elixir CI](https://github.com/dannypsnl/ecto_timescaledb/actions/workflows/elixir.yml/badge.svg)](https://github.com/dannypsnl/ecto_timescaledb/actions/workflows/elixir.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/ecto_timescaledb.svg?style=flat-square)](https://hex.pm/packages/ecto_timescaledb)
[![Hex.pm](https://img.shields.io/hexpm/dt/ecto_timescaledb.svg?style=flat-square)](https://hex.pm/packages/ecto_timescaledb)

Provide `Ecto.Timescaledb` to write TimescaleDB extended SQL.

[Documentation](https://hexdocs.pm/ecto_timescaledb/api-reference.html)

## Installation

The package can be installed by adding `ecto_timescaledb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_timescaledb, "~> 0.3.0"}
  ]
end
```

## Quick start

```elixir
import Ecto.Timescaledb
import Ecto.Query

from(s in Stat,
  select: [time_bucket("7 days", time, bucket), sum(s.avg)],
  group_by: fragment("bucket"),
  order_by: [desc: fragment("bucket")]
)
```
