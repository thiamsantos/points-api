defmodule Points.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @timestamps_opts [type: :utc_datetime_usec]
  @fields [:points]

  schema "users" do
    field :points, :integer

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end
