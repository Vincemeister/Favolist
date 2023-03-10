require "faker"
require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database..."
User.destroy_all
List.destroy_all
Product.destroy_all


puts "Creating vince, ava and 3 random users..."

vinc = User.create(username: "Vinc", email: "vr@gmail.com", password: "password")
avatar_vinc = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678342734/avatars/Linkedin_3_asp0qi.jpg")
vinc.avatar.attach(io: avatar_vinc, filename: 'vinc.jpg', content_type: 'image/jpg')
vinc.save!

ava = User.create(username: "Ava", email: "ah@gmail.com", password: "password" )
avatar_ava = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678342666/avatars/ava_s7jzz7.jpg")
ava.avatar.attach(io: avatar_ava, filename: 'ava.jpg', content_type: 'image/jpg')
ava.save!

chris = User.create(username: "Chris", email: "cs@gmail.com", password: "password" )
avatar_chris = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678430825/avatars/crhis_skk7j0.png")
chris.avatar.attach(io: avatar_chris, filename: 'ava.jpg', content_type: 'image/jpg')
chris.save!

3.times do
  avatar = URI.open("https://source.unsplash.com/random/?profile")
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: "password")
end


puts "Establishing 4 followships..."

Follow.create(follower_id: vinc.id, following_id: ava.id)
Follow.create(follower_id: ava.id, following_id: vinc.id)
Follow.create(follower_id: vinc.id, following_id: chris.id)
Follow.create(follower_id: vinc.id, following_id: User.last.id)


puts "Creating 3 lists..."


sleep_enhancers = List.create(title: "Sleep Enhancers", user_id: vinc.id)
travel_gear = List.create(title: "Travel Gear", user_id: vinc.id)
every_day_saviors = List.create(title: "Every Day Saviors", user_id: ava.id)
functional_apparel = List.create(title: "Functional Apparel", user_id: chris.id)


############################# Products #############################


puts "Creating 4 products..."

#Nomatic Backpack
nomatic = Product.create(
  list: sleep_enhancers,
  title: "NOMATIC Backpack",
  price: 250,
  review: "Stylish af bag I take with me every day.\n

  Usually I carry my kindl, nextstand, keyboard, mouse, journal and other items in it. When travelling it also
  accomodate the items I don’t want to put in the checked baggage.Large enough for day trips: can carry a big bottle,
  16-inch macbook pro, ipad, a set of clothing for 2 days (bar trousers) and is just my little baby.\n

  Thank you brother for this surprise Christmas gift which I told you to get me after doing my usual 4 hours of research
  to find the best. Once again, this brand appears in every “Top 5” blog post about laptop bags.
  I’ve had it for four years now and it’s basically in the same shape as when I bought it.
  The design buffers shock so that my laptop survived bump here and there.\n
  I just love this thing. Check it out for yourself. Ah yes, and it’s water resistant.",

  description: "The NOMATIC Travel Pack was designed for everyday use and for those shorter 1-3 day trips. It’s made
  with durable, water-resistant materials and YKK zippers. Expanding 50%, this bag is slim but expands when you need to
  pack more. The patent pending strap system allows you to go from backpack to briefcase carry for those times when you
  need to look more professional.\n

  The full perimeter zipper, magnetic water bottle pockets, RFID safe storage, and hidden pockets are just a few of the
  20+ noteworthy features that make the Travel Pack the most functional travel pack ever! On top of being packed with
  incredible functionality, the NOMATIC Travel Pack has a sleek minimalist design and gives you confidence for your
  life on the move.\n

  Includes\n
  Sunglasses Case\n
  Retractable Key-Leash",

  referrals: "Use code 'NOMAD' and you get 15% off your first purchase. I also get 15% off my next purchase!"
)
files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678248287/favolist/app%20assets/product%20images/nomatic/1_n0hwaz.webp"),
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678248287/favolist/app%20assets/product%20images/nomatic/2_om7ibb.webp"),
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678248288/favolist/app%20assets/product%20images/nomatic/7_avpl4s.webp")
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678265282/favolist/app%20assets/product%20images/nomatic/Nomatic_Black_jvzodf.webp")
nomatic.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
nomatic.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
nomatic.save!


#Manta Sleep Mask

manta = Product.create(
  list: every_day_saviors,
  title: "Manta Sleep Mask",
  price: 57,
  review: "This sleep mask is the best I’ve ever used. I’ve tried a few different ones and this one is the most comfortable.
   It's made out of silk, and you enter a different world. I promise. Also, I have a great referral code! Buy it! Filling text now. Don't know what to write lol."
)
files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678429148/favolist/app%20assets/product%20images/manta/manta_mma3bu.webp"),
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678429180/favolist/app%20assets/product%20images/manta/manta_logo_b40jnq.png")
manta.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
manta.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
manta.save!


#Baubax Travel Jacket 3.0
baubax = Product.create(
  list: functional_apparel,
  title: "Baubax Travel Jacket 3.0",
  price: 120,
  review: "I love this jacket. It’s so comfortable and has so many pockets. I love the fact that it has an infinite number of pockets.
  Also, it's stylish af and I get compliments on it all the time. I also have a great referral code! Buy it! Filling text now. Don't know what to write lol."
)
files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678429214/favolist/app%20assets/product%20images/baubax/baubax_beige_bmu27g.webp"),
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678435398/favolist/app%20assets/product%20images/baubax/baubax_iy3mmb.webp")
baubax.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
baubax.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
baubax.save!


#Apple AirTag
apple = Product.create(
  list: every_day_saviors,
  title: "Apple AirTag",
  price: 120,
  review: "I'm a professional loser. I've lost my keys, wallet, phone, and passport. I've lost my luggage. I've lost my dog. I definitely lost my soul as well. So obviously this
  is a must have for me. I also have a great referral code! So go ahead. Buy it! Filling text now. Don't know what to write lol."
)
files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678429316/favolist/app%20assets/product%20images/apple/apple_air_tag_nslh0x.jpg"),
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678435291/favolist/app%20assets/product%20images/apple/Apple-logo_xnjrqa.png")
apple.photos.attach(files.map { |f| { io: f, filename: "image.png", content_type: "image/png" } })
apple.logo.attach(io: logo, filename: "image.jpg", content_type: "image/png")
apple.save!
