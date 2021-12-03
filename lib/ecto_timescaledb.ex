defmodule Ecto.Timescaledb do
  @moduledoc """
  Documentation for `Ecto.Timescaledb`.
  """

  defmacro as(a, b) do
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
        select: [time_bucket("7 days", bucket), sum(s.avg)],
        group_by: fragment("bucket"),
        order_by: [desc: fragment("bucket")]
      )

  """
  defmacro time_bucket(duration, name) do
    quote do
      fragment(unquote("time_bucket(?, time) " <> Macro.to_string(name)), unquote(duration))
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
