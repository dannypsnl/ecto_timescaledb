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

  def yes(sql, keys, opts) do
    Enum.flat_map_reduce(
      keys,
      sql,
      fn argument, sql ->
        if opts[argument] do
          {:halt, sql <> ", #{Atom.to_string(argument)} => #{opts[argument]}"}
        else
          {:halt, sql}
        end
      end
    )
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
  defmacro create_hypertable(relation, time_column_name, opts \\ []) do
    sql =
      "SELECT create_hypertable('#{Atom.to_string(relation)}', '#{Atom.to_string(time_column_name)}'"

    {_, sql} =
      yes(
        sql,
        [
          :partitioning_column,
          :number_partitions,
          :chunk_time_interval,
          :create_default_indexes,
          :if_not_exists,
          :partitioning_func,
          :associated_schema_name,
          :associated_table_prefix,
          :migrate_data,
          :time_partitioning_func,
          :replication_factor,
          :data_nodes
        ],
        opts
      )

    sql = sql <> ")"

    quote do
      execute(unquote(sql))
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

    {_, sql} =
      yes(
        sql,
        [:number_partitions, :chunk_time_interval, :partitioning_func, :if_not_exists],
        opts
      )

    sql = sql <> ")"

    quote do
      execute(unquote(sql))
    end
  end
end
