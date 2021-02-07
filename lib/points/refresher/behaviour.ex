defmodule Points.Refresher.Behaviour do
  alias Points.Users.User

  @callback fetch_users(GenServer.server()) :: [User.t()]
end
