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
end
