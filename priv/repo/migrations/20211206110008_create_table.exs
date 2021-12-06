defmodule Support.Repo.Migrations.CreateTable do
  use Ecto.Migration.Timescaledb

  def up do
    create table(:test_table, primary_key: false) do
      add :time, :naive_datetime, null: false
      add :example, :string
      add :location, :string
    end

    create_hypertable(:test_table, :time)
    add_dimension(:test_table, :location, number_partitions: 4, if_not_exists: true)
  end

  def down do
    drop(table(:test_table))
  end
end
