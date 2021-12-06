defmodule Ecto.Migration.Timescaledb do
  @moduledoc """
  Provides migration related functions in [TimescaleDB](https://www.timescale.com/) extended SQL for `Ecto.Query`
  """

  @doc """
  [create_hypertable](https://docs.timescale.com/api/latest/hypertable/create_hypertable/#create-hypertable)

  ## Examples

  ```
  use Ecto.Migration
  use Ecto.Migration.Timescaledb

  select(create_hypertable(:stat, :time))
  ```
  """
  defmacro create_hypertable(relation, time_column_name) do
    quote do
      fragment(unquote("create_hypertable(?, ?)"), unquote(relation), unquote(time_column_name))
    end
  end
end
