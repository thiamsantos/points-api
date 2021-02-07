defmodule Points.Refresher.State do
  defstruct max_number: nil, users: [], timestamp: nil, refresh_interval: nil

  def new(refresh_interval, max_number) do
    %__MODULE__{refresh_interval: refresh_interval, max_number: max_number}
  end

  def refresh_max(state) do
    %{state | max_number: Enum.random(0..100)}
  end

  def put_users(state, users) do
    %{state | users: users, timestamp: DateTime.utc_now()}
  end
end
