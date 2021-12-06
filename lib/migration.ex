defmodule Ecto.Migration.Timescaledb do
  @moduledoc """
  Provides migration related functions in [TimescaleDB](https://www.timescale.com/) extended SQL for `Ecto.Query`
  """

  def __using__(_options) do
    quote do
    end
  end

  @doc """
  [create_hypertable](https://docs.timescale.com/api/latest/hypertable/create_hypertable/#create-hypertable)

  ## Examples

  ```
  use Ecto.Migration
  use Ecto.Migration.Timescaledb

  create_hypertable(user, joined_at)
  ```
  """
  defmacro create_hypertable(relation, time_column_name) do
    quote do
      execute(
        unquote(
          "SELECT create_hypertable('" <>
            Macro.to_string(relation) <>
            "', '" <> Macro.to_string(time_column_name) <> "')"
        )
      )
    end
  end
end
