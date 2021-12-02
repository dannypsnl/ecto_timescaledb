defmodule EctoTimescaledbTest do
  use ExUnit.Case
  import CompareSQL
  import Ecto.Query
  import Ecto.Timescaledb

  test "time_bucket function" do
    assert from(e in "E",
             select: time_bucket("10 days", ten_days)
           )
           <~> from(e in "E",
             select: fragment("time_bucket('10 days', time) ten_days")
           )
  end

  test "as function" do
    assert from(e in "E",
             select: as(e.id, e_id)
           )
           <~> from(e in "E",
             select: fragment("? AS e_id", e.id)
           )
  end
end
