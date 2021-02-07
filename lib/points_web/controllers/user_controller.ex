defmodule PointsWeb.UserController do
  use PointsWeb, :controller

  alias Points.Refresher

  def index(conn, _params) do
    %{timestamp: timestamp, users: users} = Refresher.fetch_users(Refresher)

    conn
    |> put_status(:ok)
    |> render("index.json", %{users: users, timestamp: timestamp})
  end
end
