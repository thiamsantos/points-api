defmodule Points.Refresher do
  @behaviour Points.Refresher.Behaviour

  @impl true
  def fetch_users(server) do
    adapter().fetch_users(server)
  end

  defp adapter do
    :points
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:adapter)
  end
end
