defmodule CompareSQL do
  alias Test.Repo

  def a <~> b,
    do: Ecto.Adapters.SQL.to_sql(:all, Repo, a) == Ecto.Adapters.SQL.to_sql(:all, Repo, b)
end