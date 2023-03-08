require "faker"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



vince = User.create(username: "vince", email: "vr@gmail.com", password: "password")
ava = User.create(username: "ava", email: "ah@gmail.com", password: "password", following: [first_user])

3.times do
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: "password")
end
