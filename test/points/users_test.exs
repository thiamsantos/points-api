defmodule Points.UsersTest do
  use Points.DataCase, async: true

  alias Points.Users
  alias Points.Users.User

  describe "update_all_users_with_random_points/0" do
    test "update with random point number" do
      user_1 = Repo.insert!(%User{points: 0})
      user_2 = Repo.insert!(%User{points: 0})

      Users.update_all_users_with_random_points()

      assert Repo.reload!(user_1).points in 0..100
      assert Repo.reload!(user_2).points in 0..100
    end
  end

  describe "fetch_users_with_more_points/1" do
    test "fetch users with more points than max" do
      user_1 = Repo.insert!(%User{points: 90})
      user_2 = Repo.insert!(%User{points: 91})

      assert Users.fetch_users_with_more_points(80) == [user_2, user_1]
    end

    test "returns a max of 2 users" do
      for _ <- 1..5 do
        Repo.insert!(%User{points: 90})
      end

      users = Users.fetch_users_with_more_points(80)
      assert length(users) == 2
    end

    test "ignore users with less or equal than max" do
      Repo.insert!(%User{points: 10})

      assert Users.fetch_users_with_more_points(10) == []
    end
  end
end
