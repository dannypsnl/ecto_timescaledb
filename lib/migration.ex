defmodule Ecto.Migration.Timescaledb do
  @moduledoc """
  Provides migration related functions in [TimescaleDB](https://www.timescale.com/) extended SQL for `Ecto.Query`
  """

  def __using__(_options) do
    quote do
      use Ecto.Migration

      @doc """
      [create_hypertable](https://docs.timescale.com/api/latest/hypertable/create_hypertable/#create-hypertable)

      ## Examples

      ```
      use Ecto.Migration.Timescaledb

      create_hypertable(:stat, :time)
      ```
      """
      def create_hypertable(relation, time_column_name) do
        execute(fn ->
          repo().query!("SELECT create_hypertable($1, $2)", [relation, time_column_name],
            log: :info
          )
        end)
      end
    end
  end
end
