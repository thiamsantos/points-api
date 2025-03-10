defmodule Points.Refresher.Server do
  @behaviour Points.Refresher.Behaviour

  use GenServer

  alias Points.Refresher.State
  alias Points.Users

  def start_link(opts) do
    {refresh_interval, opts} = Keyword.pop(opts, :refresh_interval, :timer.minutes(1))
    {max_number, opts} = Keyword.pop(opts, :max_number, Enum.random(0..100))

    GenServer.start_link(
      __MODULE__,
      %{refresh_interval: refresh_interval, max_number: max_number},
      opts
    )
  end

  @impl true
  def fetch_users(pid) do
    GenServer.call(pid, :fetch_users)
  end

  @impl true
  def init(%{refresh_interval: refresh_interval, max_number: max_number}) do
    schedule_work(refresh_interval)

    {:ok, State.new(refresh_interval, max_number)}
  end

  @impl true
  def handle_call(:fetch_users, _from, state) do
    %{timestamp: prev_timestamp, users: prev_users, max_number: max_number} = state

    new_users = Users.fetch_users_with_more_points(max_number)

    {:reply, %{timestamp: prev_timestamp, users: prev_users}, State.put_users(state, new_users)}
  end

  @impl true
  def handle_info(:refresh, %{refresh_interval: refresh_interval} = state) do
    Users.update_all_users_with_random_points()

    schedule_work(refresh_interval)

    {:noreply, State.refresh_max(state)}
  end

  defp schedule_work(refresh_interval) do
    Process.send_after(self(), :refresh, refresh_interval)
  end
end
