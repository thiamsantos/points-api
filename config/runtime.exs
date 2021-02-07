import Config

if config_env() == :test do
  config :points, Points.Repo, url: System.fetch_env!("TEST_DATABASE_URL")
else
  config :points, Points.Repo,
    # ssl: true,
    url: System.fetch_env!("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
end

config :points, PointsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
