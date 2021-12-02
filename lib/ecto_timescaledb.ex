defmodule Ecto.Timescaledb do
  @moduledoc """
  Documentation for `Ecto.Timescaledb`.
  """

  require Ecto.Query

  @doc """
  time_bucket extension in timescaledb

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
end
