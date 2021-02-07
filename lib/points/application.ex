defmodule Points.Application do
  use Application

  def start(_type, _args) do
    children = [
      Points.Repo,
      {Phoenix.PubSub, name: Points.PubSub},
      PointsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Points.Supervisor]
    Supervisor.start_link(children ++ runtime_children(), opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PointsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  @env Mix.env()

  def runtime_children do
    if @env == :test do
      []
    else
      [
        {Points.Refresher.Server, name: Points.Refresher}
      ]
    end
  end
end
