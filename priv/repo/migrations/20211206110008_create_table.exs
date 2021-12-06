defmodule Support.Repo.Migrations.CreateTable do
  use Ecto.Migration
  import Ecto.Migration.Timescaledb

  def up do
    create table(:test_table, primary_key: false) do
      add :time, :naive_datetime, null: false
      add :example, :string
    end

    create_hypertable(test_table, time)
  end

  def down do
    drop(table(:test_table))
  end
end
