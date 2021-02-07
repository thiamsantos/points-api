defmodule PointsWeb.UserControllerTest do
  use PointsWeb.ConnCase, async: true
  import Mox
  alias Points.RefresherMock
  alias Points.Users.User

  setup :verify_on_exit!

  describe "/ [index]" do
    test "initial state", %{conn: conn} do
      expect(RefresherMock, :fetch_users, fn _ -> %{users: [], timestamp: nil} end)

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(:ok)

      assert response == %{"users" => [], "timestamp" => nil}
    end

    test "render users", %{conn: conn} do
      user_1 = %User{id: 1, points: 30}
      user_2 = %User{id: 72, points: 30}
      timestamp = ~U[2020-07-30 17:09:33Z]

      expect(RefresherMock, :fetch_users, fn _ ->
        %{users: [user_1, user_2], timestamp: timestamp}
      end)

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(:ok)

      assert response == %{
               "users" => [%{"id" => 1, "points" => 30}, %{"id" => 72, "points" => 30}],
               "timestamp" => "2020-07-30T17:09:33Z"
             }
    end
  end
end
