defmodule Ecto.Timescaledb do
  @moduledoc """
  Documentation for `Ecto.Timescaledb`.
  """

  @doc """
  Stands for AS

  ## Examples

      import Ecto.Timescaledb
      import Ecto.Query

      from(s in Stat,
        select: sum(s.avg) ~> avg,
        order_by: [desc: fragment("avg")]
      )

  """
  defmacro a ~> b do
    quote do
      fragment(unquote("? AS " <> Macro.to_string(b)), unquote(a))
    end
  end

  @doc """
  [time_bucket](https://docs.timescale.com/api/latest/hyperfunctions/time_bucket/) extension in timescaledb

  ## Examples

      import Ecto.Timescaledb
      import Ecto.Query

      from(s in Stat,
        select: [time_bucket("7 days", time, bucket), sum(s.avg)],
        group_by: fragment("bucket"),
        order_by: [desc: fragment("bucket")]
      )

  """
  defmacro time_bucket(bucket_width, ts, name) do
    quote do
      fragment(
        unquote("time_bucket(?, " <> Macro.to_string(ts) <> ") " <> Macro.to_string(name)),
        unquote(bucket_width)
      )
    end
  end

  @doc """
  [time_bucket_ng](https://docs.timescale.com/api/latest/hyperfunctions/time_bucket_ng/) extension in timescaledb
  """
  defmacro time_bucket_ng(bucket_width, ts) do
    quote do
      fragment(
        unquote("timescaledb_experimental.time_bucket_ng(?, " <> Macro.to_string(ts) <> ")"),
        unquote(bucket_width)
      )
    end
  end

  @doc """
  [histogram](https://docs.timescale.com/api/latest/hyperfunctions/histogram/)
  """
  defmacro histogram(value, min, max, nbuckets) do
    quote do
      fragment(
        "histogram(?, ?, ?, ?)",
        unquote(value),
        unquote(min),
        unquote(max),
        unquote(nbuckets)
      )
    end
  end
end
