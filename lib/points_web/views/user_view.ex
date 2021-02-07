defmodule PointsWeb.UserView do
  use PointsWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, __MODULE__, "item.json"),
      timestamp: timestamp
    }
  end

  def render("item.json", %{user: user}) do
    Map.take(user, [:id, :points])
  end
end
