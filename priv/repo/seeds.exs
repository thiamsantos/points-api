alias Points.Repo
alias Points.Users.User

for _ <- 1..100 do
  Repo.insert(%User{points: 0})
end
