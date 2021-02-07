defmodule Points.Users do
  import Ecto.Query
  alias Points.Repo
  alias Points.Users.User

  defmacrop random_between(high, low) do
    quote do
      fragment("floor(random() * (? - ? + 1) + ?)", unquote(high), unquote(low), unquote(low))
    end
  end

  def update_all_users_with_random_points do
    User
    |> update(set: [points: random_between(0, 100)])
    |> Repo.update_all([])
  end

  def fetch_users_with_more_points(max_number) do
    User
    |> where([u], u.points > ^max_number)
    |> order_by(desc: :points)
    |> limit(2)
    |> Repo.all()
  end
end
