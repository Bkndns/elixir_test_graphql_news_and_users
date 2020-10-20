# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Community.Repo.insert!(%Community.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Community.Repo
alias Community.Accounts.User
alias Community.Posts.Post


for _ <- 1..10 do
  Repo.insert!(%User{name: Faker.Person.name, email: Faker.Internet.safe_email})
end

for _ <- 1..25 do
  Repo.insert!(%Post{
    title: Faker.Lorem.sentence(),
    body: Faker.Lorem.paragraph(),
    user_id: Enum.random(1..10)
  })
end
