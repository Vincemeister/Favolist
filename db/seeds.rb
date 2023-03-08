require "faker"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database..."
User.destroy_all


puts "Creating vince, ava and 3 random users..."

vince = User.create(username: "vinc", email: "vr@gmail.com", password: "password")
ava = User.create(username: "ava", email: "ah@gmail.com", password: "password" )
chris = User.create(username: "chris", email: "cs@gmail.com", password: "password" )

3.times do
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: "password")
end


puts "establishing followships..."

Follow.create(follower_id: vince.id, following_id: ava.id)
Follow.create(follower_id: ava.id, following_id: vince.id)
Follow.create(follower_id: vince.id, following_id: chris.id)
Follow.create(follower_id: vince.id, following_id: User.all.sample.id)
