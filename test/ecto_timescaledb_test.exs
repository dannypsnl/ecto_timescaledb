defmodule EctoTimescaledbTest do
  use ExUnit.Case
  import CompareSQL
  import Ecto.Query
  import Ecto.Timescaledb

  test "as function" do
    assert from(e in "E",
             select: as(e.id, e_id)
           )
           <~> from(e in "E",
             select: fragment("? AS e_id", e.id)
           )
  end

  test "time_bucket function" do
    assert from(e in "E",
             select: time_bucket("10 days", time, ten_days),
             group_by: fragment("ten_days")
           )
           <~> from(e in "E",
             select: fragment("time_bucket('10 days', time) ten_days"),
             group_by: fragment("ten_days")
           )
  end

  test "time_bucket_ng function" do
    q1 =
      from(e in "conditions",
        select: [
          e.city,
          as(time_bucket_ng("1 day", day), bucket),
          min(e.temperature),
          max(e.temperature)
        ],
        group_by: [e.city, fragment("bucket")]
      )

    q2 =
      from(e in "conditions",
        select: [
          e.city,
          fragment("timescaledb_experimental.time_bucket_ng('1 day', day) AS bucket"),
          min(e.temperature),
          max(e.temperature)
        ],
        group_by: [e.city, fragment("bucket")]
      )

    assert q1 <~> q2
  end

  test "histogram function" do
    q1 =
      from(e in "readings",
        select: [e.device_id, histogram(e.battery_level, 20, 60, 5)],
        group_by: e.device_id,
        limit: 10
      )

    q2 =
      from(e in "readings",
        select: [e.device_id, fragment("histogram(?, 20, 60, 5)", e.battery_level)],
        group_by: e.device_id,
        limit: 10
      )

    assert q1 <~> q2
  end
end
