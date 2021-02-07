import Config

Code.eval_file("./config/dotenv.exs")

config :points,
  ecto_repos: [Points.Repo]

config :points, Points.Repo, migration_timestamps: [type: :utc_datetime_usec]

# Configures the endpoint
config :points, PointsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PointsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Points.PubSub,
  live_view: [signing_salt: "aqkk1z/b"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :points, Points.Refresher, adapter: Points.Refresher.Server

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
