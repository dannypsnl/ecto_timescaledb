defmodule Ecto.Migration.Timescaledb do
  @moduledoc """
  Provides migration related functions in [TimescaleDB](https://www.timescale.com/) extended SQL for `Ecto.Query`
  """

  defmacro __using__(_options) do
    quote do
      use Ecto.Migration
      import Ecto.Migration.Timescaledb
    end
  end

  @doc """
  [create_hypertable](https://docs.timescale.com/api/latest/hypertable/create_hypertable/#create-hypertable)

  ## Examples

  ```
  use Ecto.Migration.Timescaledb

  def up do
    create table(:user, primary_key: false) do
      add :joined_at, :naive_datetime, null: false
      add :name, :string
    end

    create_hypertable(:user, :joined_at)
  end

  def down do
    drop(table(:user))
  end
  ```
  """
  defmacro create_hypertable(relation, time_column_name) do
    quote do
      execute(
        unquote(
          "SELECT create_hypertable('#{Atom.to_string(relation)}', '#{Atom.to_string(time_column_name)}')"
        )
      )
    end
  end

  @doc """
  [add_dimension](https://docs.timescale.com/api/latest/hypertable/add_dimension/#sample-usage)

  ## Examples

  ```
  use Ecto.Migration.Timescaledb

  def up do
    create_hypertable(:conditions, :time)
    add_dimension(:conditions, :location, number_partitions: 4)
  end
  ```
  """
  defmacro add_dimension(relation, column_name, opts \\ []) do
    sql = "SELECT add_dimension('#{Atom.to_string(relation)}', '#{Atom.to_string(column_name)}'"

    sql =
      if opts[:number_partitions] do
        sql <> ", number_partitions => #{opts[:number_partitions]}"
      else
        sql
      end

    sql =
      if opts[:chunk_time_interval] do
        sql <> ", chunk_time_interval => #{opts[:chunk_time_interval]}"
      else
        sql
      end

    sql =
      if opts[:partitioning_func] do
        sql <> ", partitioning_func => #{opts[:partitioning_func]}"
      else
        sql
      end

    sql =
      if opts[:if_not_exists] do
        sql <> ", if_not_exists => #{opts[:if_not_exists]}"
      else
        sql
      end

    sql = sql <> ")"

    quote do
      execute(unquote(sql))
    end
  end
end
