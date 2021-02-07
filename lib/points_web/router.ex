defmodule PointsWeb.Router do
  use PointsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PointsWeb do
    pipe_through :api

    get "/", UserController, :index
  end
end
