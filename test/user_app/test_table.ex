defmodule Support.Table.TestTable do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "test_table" do
    field :time, :naive_datetime, null: false
    field :example, :string
  end

  @doc false
  def changeset(stat, attrs) do
    stat
    |> cast(attrs, [
      :time,
      :example
    ])
    |> validate_required([:time, :example])
  end
end
