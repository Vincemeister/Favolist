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


puts "Creating main users and tim"

main_users = []

vinc = User.create(username: "Vinc", email: "vr@gmail.com", password: "password")
avatar_vinc = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678342734/avatars/Linkedin_3_asp0qi.jpg")
vinc.avatar.attach(io: avatar_vinc, filename: 'vinc.jpg', content_type: 'image/jpg')
vinc.save!
main_users << vinc

tim = User.create(username: "Tim", email: "tf@gmail.com", password: "password" )
avatar_tim = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678939284/avatars/1482346021-tim_ferriss_tickets_imu1hz.jpg")
tim.avatar.attach(io: avatar_tim, filename: 'tim.jpg', content_type: 'image/jpg')
tim.save!

ava = User.create(username: "Ava", email: "ah@gmail.com", password: "password" )
avatar_ava = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678342666/avatars/ava_s7jzz7.jpg")
ava.avatar.attach(io: avatar_ava, filename: 'ava.jpg', content_type: 'image/jpg')
ava.save!
main_users << ava

chris = User.create(username: "Chris", email: "cs@gmail.com", password: "password" )
avatar_chris = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678430825/avatars/crhis_skk7j0.png")
chris.avatar.attach(io: avatar_chris, filename: 'chris.jpg', content_type: 'image/jpg')
chris.save!
main_users << chris

jing = User.create(username: "Jing", email: "jy@gmail.com", password: "password" )
avatar_jing= URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678963348/avatars/jing_xd656p.jpg")
jing.avatar.attach(io: avatar_jing, filename: 'jing.jpg', content_type: 'image/jpg')
jing.save!
main_users << jing

nina = User.create(username: "Nina", email: "ni@gmail.com", password: "password" )
avatar_nina= URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678963419/avatars/nina_hwia3y.jpg")
nina.avatar.attach(io: avatar_nina, filename: 'nina.jpg', content_type: 'image/jpg')
nina.save!
main_users << nina

ramesh = User.create(username: "Ramesh", email: "ra@gmail.com", password: "password" )
avatar_ramesh= URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678963390/avatars/ramesh_uq7kp6.jpg")
ramesh.avatar.attach(io: avatar_ramesh, filename: 'ramesh.jpg', content_type: 'image/jpg')
ramesh.save!
main_users << ramesh



puts "Creating 50 random users"

random_users = []

  3.times do
  avatar = URI.open("https://source.unsplash.com/random/?user-profile-picture")
  user = User.create(username: Faker::Name.first_name, email: Faker::Internet.email, password: "password")
  user.avatar.attach(io: avatar, filename: 'avatar.jpg', content_type: 'image/jpg')
  random_users << user
end

puts "Creating random lists and 50 random products for dummy users"

random_users.each do |user|
  # Randomly create between 1 and 15 lists for each user
  (rand(1..3)).times do
    list = List.create(user: user, title: Faker::Lorem.sentence(word_count: 3))

    # Randomly create between 1 and 7 products for each list
    (rand(1..3)).times do
      Product.create(list: list, title: Faker::Commerce.product_name, price: Faker::Commerce.price(range: 1..100.0))
    end
  end
end




puts "Establishing main followships..."

Follow.create(follower_id: vinc.id, following_id: ava.id)
Follow.create(follower_id: ava.id, following_id: vinc.id)
Follow.create(follower_id: vinc.id, following_id: chris.id)
Follow.create(follower_id: vinc.id, following_id: tim.id)
Follow.create(follower_id: tim.id, following_id: vinc.id)
Follow.create(follower_id: vinc.id, following_id: ramesh.id)
Follow.create(follower_id: vinc.id, following_id: nina.id)
Follow.create(follower_id: vinc.id, following_id: jing.id)



puts "Establishing 40 random followships..."
random_users.each do |user|
  used_following_ids = [] # Empty array to keep track of used following IDs
  num_followings = rand(1..3) # Generate a random number of followings for each user

  num_followings.times do
    following_id = main_users.sample.id # Generate a random following ID
    while used_following_ids.include?(following_id) || user.id == following_id # Check if the ID has been used before or if it's the user's own ID
      following_id = main_users.sample.id # Generate a new ID if it has
    end

    Follow.create(follower_id: user.id, following_id: following_id) # Create the follow relationship
    used_following_ids << following_id # Add the ID to the used_following_ids array
  end
end

puts "Establishing Tims followships random followships..."


random_users.reject { |user| user.id == tim.id }.each do |user|
  Follow.create(follower_id: user.id, following_id: tim.id)
end

follow_count = 0
max_tries = random_users.count * 5

while follow_count < 15
  random_user_id = random_users.sample.id

  if !tim.following.exists?(random_user_id) && random_user_id != tim.id
    Follow.create(follower_id: tim.id, following_id: random_user_id)
    follow_count += 1
  end

  max_tries -= 1
  break if max_tries <= 0
end

if max_tries <= 0
  puts "Warning: Not all followships created, please check the user pool."
end





User.all

puts "Creating random lists and random products for main users except tim"

main_users.each do |user|
  # Randomly create between 1 and 15 lists for each user
  (rand(1..3)).times do
    list = List.create(user: user, title: Faker::Lorem.sentence(word_count: 3))

    # Randomly create between 1 and 7 products for each list
    (rand(1..3)).times do
      Product.create(list: list, title: Faker::Commerce.product_name, price: Faker::Commerce.price(range: 1..100.0))
    end
  end
end





puts "Creating list..."



puts "creating lists of products that appear in the feed"

every_day_saviors = List.create(title: "Every Day Saviors", user_id: vinc.id)
functional_apparel = List.create(title: "Functional Apparel", user_id: vinc.id)
healthtech_gadgets = List.create(title: "Fitness", user_id: vinc.id)
alcohol_alternatives = List.create(title: "Alcohol Alternatives", user_id: vinc.id)
my_zen_list = List.create(title: "Mindfulness & Relaxation", user_id: vinc.id)
dreamy_time_list = List.create(title: "Dreamy Time List", user_id: vinc.id)
travel_gear = List.create(title: "Adventure & Travel Gear", user_id: vinc.id)



puts "creating tim ferriss lists"

sleep_enhancers = List.create(title: "Sleep Enhancers", user_id: tim.id)
food_and_health_supplements = List.create(title: "Food & Supplements", user_id: tim.id)
fitness = List.create(title: "Fitness", user_id: tim.id)
mood_boosters = List.create(title: "Mood Boosters", user_id: tim.id)
productivity_boosters = List.create(title: "Productivity Boosters", user_id: tim.id)
functional_clothing = List.create(title: "Apparel", user_id: tim.id)




############################# Products #############################


puts "Creating feed products..."

oura_ring = Product.create(
  list: healthtech_gadgets,
  title: "Oura Ring",
  review: "I've been using the Oura Ring for a few weeks now, and I have to say, I'm impressed. The device is incredibly accurate when it comes to tracking my sleep patterns, and I've been able to use the insights it provides to make some changes to my sleep routine that have really helped me feel more rested and energized during the day.

  I also appreciate the fact that the Oura Ring is so easy to wear and forget about. Unlike other fitness trackers or smartwatches, I hardly even notice that I'm wearing it, which makes it much more convenient to use on a daily basis.

  While I have noticed a few minor issues with the accuracy of the activity tracking (particularly when it comes to tracking specific exercises), I still find the overall insights and data provided by the device to be incredibly valuable. Overall, I would definitely recommend the Oura Ring to anyone who is looking for a more comprehensive and accurate way to track their sleep and overall health.",
  price: 199,
  description: "The Oura Ring is a sleek and stylish fitness tracker that monitors your sleep, activity, and recovery. Its advanced sensors track your heart rate, body temperature, and movement throughout the night, providing valuable insights into your sleep quality and overall health. The Oura Ring also features a personalized readiness score that helps you optimize your daily activity levels based on your body's needs. With its elegant design and cutting-edge technology, the Oura Ring is the perfect tool for anyone looking to improve their health and fitness.",
  referrals: "You can purchase the Oura Ring on their official website or through select retailers. FOR THE FEED",
  )

  files = [
    URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956470/favolist/app%20assets/product%20images/more%20products/https___s3.amazonaws.com_ouraring.com_images_product_simple_pdp-img-carousel-silver-03-heritage_2x_nmfat3.webp"),
  ]
  logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956487/favolist/app%20assets/product%20images/more%20products/7B24ADCF-7925-4513-A32B-B81476285567_1_105_c_ux0tuv.jpg")
  oura_ring.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
  oura_ring.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
  oura_ring.save!

  oura_ring.save!



  kin_nootropic = Product.create(
    list: alcohol_alternatives,
    title: "Kin Nootropic",
    description: "Kin Euphorics are a new kind of drink, carefully crafted to help you take the edge off and be your most productive, social, creative self. Kin's patented nootropic formula combines ancient adaptogens with modern alchemy, and is designed to elevate your mood and help you find your bliss. Kin's all-natural ingredients include GABA, 5-HTP, and caffeine to help you de-stress, sharpen your focus, and get a natural buzz.",
    price: 39,
    review: "Kin Nootropic is the perfect drink for anyone looking to stay productive and focused without the negative side effects of alcohol. The taste is great, and the effects are even better. I've found that I can enjoy Kin in a social setting and still stay sharp and focused.",
    referrals: "Check out Kin Euphorics and get 15% off your first purchase with code TIM at kineuphorics.com. FOR THE FEED",
    )

    files = [
      URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956604/favolist/app%20assets/product%20images/more%20products/download_bwokam.jpg"),
    ]
    logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956635/favolist/app%20assets/product%20images/more%20products/atvargchrwtmdyybr5qy_pe3sfg.png")
    kin_nootropic.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
    kin_nootropic.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
    kin_nootropic.save!



    copic_multiliner = Product.create(
    list: my_zen_list,
    title: "Copic 1.0mm Multiliner",
    description: "The Copic 1.0mm Multiliner is the perfect pen for any artist or writer. Its durable tip allows for smooth, consistent lines, and its waterproof and archival ink ensures that your work will last a lifetime. With its comfortable grip and sleek design, the Copic 1.0mm Multiliner is a must-have for anyone who takes their writing or drawing seriously.",
    price: 5.99,
    review: "I've been using the Copic 1.0mm Multiliner for years, and it's never let me down. The ink flows smoothly and the tip is just the right size for my needs. I love the sleek design and the comfortable grip, which makes it easy to use for long periods of time.",
    referrals: "FOR THE FEED",
    )

    files = [
      URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956715/favolist/app%20assets/product%20images/more%20products/CZ2307511-bs__39559_xus313.jpg"),
    ]
    logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956717/favolist/app%20assets/product%20images/more%20products/1200px-Copic_brand_logo.svg_detf0n.png")
    copic_multiliner.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
    copic_multiliner.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
    copic_multiliner.save!




#Manta Sleep Mask

manta = Product.create(
  list: dreamy_time_list,
  title: "Manta Sleep Mask",
  price: 57,
  review: "This sleep mask is the best I’ve ever used. I’ve tried a few different ones and this one is the most comfortable.
   It's made out of silk, and you enter a different world. I promise. It's absolutely amazing.",
  referrals: "FOR THE FEED"
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
  list: apparel,
  title: "Baubax Travel Jacket 3.0",
  price: 120,
  review: "I love this jacket. It’s so comfortable and has so many pockets. I love the fact that it has an infinite number of pockets.
  Also, it's stylish af and I get compliments on it all the time. I also have a great referral code! Buy it!",
  referrals: "FOR THE FEED"
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
  review: "I'm a professional loser. I've lost my keys, wallet, phone, and passport. I've lost my luggage. So obviously this
  is a must have for me. So amazing that Apple comes up with a product like this, which means it's also uniquely and beautifully designed.",
  referrals: "FOR THE FEED"

)
files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678429316/favolist/app%20assets/product%20images/apple/apple_air_tag_nslh0x.jpg"),
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678435291/favolist/app%20assets/product%20images/apple/Apple-logo_xnjrqa.png")
apple.photos.attach(files.map { |f| { io: f, filename: "image.png", content_type: "image/png" } })
apple.logo.attach(io: logo, filename: "image.jpg", content_type: "image/png")
apple.save!



#################### FEED PRODUCTS ######################
puts "creating feed products"


#ButcherBox
butcher_box = Product.create(
  list: food_and_health_supplements,
  title: "ButcherBox",
  price: 169,
  review: "As a meat lover, I'm really picky about where my meat comes from. ButcherBox makes it easy for me to access high-quality meats that I can feel good about. The beef, chicken, pork, and seafood that they deliver to my doorstep is 100% grass-fed, grass-finished, free-range organic, and humanely raised. Plus, they're committed to animal welfare and environmental sustainability, which makes me feel good about supporting them. ButcherBox's selection has made it easy for me to try new recipes and cook with family and friends. If you're a meat lover like me, I highly recommend ButcherBox.",

  description: "ButcherBox is a subscription service that delivers high-quality meats and proteins directly to your doorstep. Their meats are 100% grass-fed, grass-finished beef; free-range organic chicken; humanely raised pork; and wild-caught seafood. ButcherBox is committed to supporting animal welfare, treating ecosystems with respect, and prioritizing social and environmental performance, transparency, and accountability. With ButcherBox, you can easily access meats that you can feel good about eating and serving to your family and friends. Plus, their delivery service makes it easy to get fresh, high-quality meats without having to leave your home.",

  referrals: "Sign up for ButcherBox today and get two 10 oz New York strip steaks for free in every box you order for a year. Use this link to access ButcherBox's best Black Friday deal ever*: https://www.butcherbox.com/lander/specialoffer-g?utm_campaign=chicken-nuggets-for-year
  *Offer valid for a limited time only. Restrictions may apply. FOR THE FEED",

  )
  files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704007/favolist/app%20assets/product%20images/tim%20ferris/ButcherBox/ButcherBox_b2ulmp.jpg")
  ]

  logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704007/favolist/app%20assets/product%20images/tim%20ferris/ButcherBox/butcherbox_-_logo_yn40hb.png")
  butcher_box.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
  butcher_box.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
  butcher_box.save!


#HELIX SLEEP

  helix = Product.create(
    list: sleep_enhancers,
    title: "HELIX Sleep Mattress",
    price: 1099,
    review: "I’ve had a long-standing love affair with sleep products. I’ve tried just about everything, from blackout curtains to earplugs, sleep masks to white noise machines, and more. A good mattress is a crucial part of getting quality sleep, and Helix has blown me away with their innovative and customized sleep solutions. They have a mattress that suits everyone’s unique needs, preferences, and sleeping style, and their quiz is a game changer. Their proprietary technology matches your body type and sleep preferences with the perfect mattress for you, and they’ll even pick it up from you if you don’t love it. Plus, it’s CertiPUR-US® Certified, so there are no harmful chemicals to worry about. If you’re looking for a mattress that will give you the best sleep of your life, look no further than Helix.",
    description: "Helix was selected as the #1 best overall mattress of 2020 by GQ magazine, Wired, Apartment Therapy, and many others. With Helix, there’s a specific mattress for each and every body’s unique taste. Just take their quiz—only two minutes to complete—that matches your body type and sleep preferences to the perfect mattress for you. They have a 10-year warranty, and you get to try it out for a hundred nights, risk free. They’ll even pick it up from you if you don’t love it. Designed to provide the best sleep of your life with no harmful chemicals - CertiPUR-US® Certified.",
    referrals: "Get up to $200 off all mattress orders plus two free pillows at HelixSleep.com/Tim. FOR THE FEED"
    )
    files = [
    URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678783878/favolist/app%20assets/product%20images/tim%20ferris/Mattress/Helix_cj4ycg.jpg")
    ]
    logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678783877/favolist/app%20assets/product%20images/tim%20ferris/Mattress/Helix-Logo_z9mlxj.jpg")
    helix.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
    helix.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
    helix.save!



# Pod 3 Cover
pod_cover = Product.create(
  list: sleep_enhancers,
  title: "Pod 3 Cooling Cover",
  price: 1945,
  review: "Temperatureis one of the main causes of poor sleep, and heat is my nemesis. I’ve suffered for decades, tossing and turning, throwing blankets off, pulling them back on, and repeating ad nauseam.
  The Pod 3 Cover has been a game changer for the quality of my sleep and the quality of my life. It pairs dynamic cooling and heating with biometric tracking to offer the most advanced (and user-friendly) solution on the market.
  I’ve been using Eight Sleep for more than two years. Just in time for the holidays, add the Pod 3 Cover to your current mattress and start sleeping as cool as 55°F or as hot as 110°F. It also splits your bed in half, so your partner can choose a totally different temp.
  The Pod technology adjusts the temperature of each side of the bed based on your sleep stages, biometrics, and bedroom temperature, reacting intelligently to create the optimal sleeping environment.",


  description: "The Pod 3 Cooling Cover from Eight Sleep is a revolutionary product that improves the quality of your sleep by keeping you at the optimal temperature all night long.
  With dynamic cooling and heating, biometric tracking, and the ability to adjust each side of the bed to different temperatures, the Pod 3 Cover is the most advanced and user-friendly solution on the market.
  It seamlessly fits onto a 10”-11” mattress and tracks your sleep without the need for a wearable device. Get more energy and better sleep with the Pod 3 Cooling Cover from Eight Sleep.",
  referrals: "For a limited time, Eight Sleep is offering subscribers of 5-Bullet Friday $450 off(!) of their Sleep Fit Holiday Bundle, which includes my personal favorite, the Pod 3 Cover. Click here to get the exclusive holiday savings until November 30th.*: https://www.eightsleep.com/tim/ FOR THE FEED",
)

files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704407/favolist/app%20assets/product%20images/tim%20ferris/Pod%203%20Cover/Pod_3_Cover_keri9v.jpg")
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704407/favolist/app%20assets/product%20images/tim%20ferris/Pod%203%20Cover/Pod_3_Cover_-_logo_zd6wil.png")
pod_cover.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
pod_cover.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
pod_cover.save!


# Peloton Row
peloton_row = Product.create(
  list: fitness,
  title: "Peloton Row",
  price: 3195,
  review: "Peloton Row brings personalized form features to rowing to help you learn and master your stroke. Form features like Form Assist indicate how to improve your stroke in class in real time, as well as a detailed post-class breakdown so you can hit the Row harder next time. And with features that allow you to personalize your target metrics, you become an expert at the level and pace that feels good for you. You get all your cardio and strength in one shot, while protecting your joints and ligaments in a high-intensity, low-impact way. Fun fact: you work 86% of your muscles in only 15 minutes.",
  description: "Peloton Row offers a variety of classes for all levels plus game-changing features that help you get rowing or advance the rowing you can already do. Explore Peloton Row at OnePeloton.com/Row.",
  referrals: "Right now is the perfect time to get rowing with Peloton Row. Check out their website for more information. FOR THE FEED"
)

files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942754/favolist/app%20assets/product%20images/tim%20ferris/Peloton%20Row/Peloton_Row_vhemkl.png")
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942753/favolist/app%20assets/product%20images/tim%20ferris/Peloton%20Row/Peloton_Row-logo_l7zklg.png")

peloton_row.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
peloton_row.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
peloton_row.save!

################### FOOD AND HEALTH SUPLEMENTS ###################


# Four Sigmatic Mushroom Coffee with Lion's Mane
four_sigmatic = Product.create(
  list: food_and_health_supplements,
  title: "Four Sigmatic Mushroom Coffee with Lion's Mane",
  price: 99,
  review: "You’ve heard me talk about these guys for years. I love their mushroom coffee with lion’s mane. It’s delicious, I recommend it, I gift it to my employees, and I give it to my houseguests. It’s my solution when I need to recharge but want to avoid the jitters I sometimes get from regular coffee. Their Reishi Elixir has also been a game changer for sleep.",
  description: "Get your brain going with Lion's Mane. Support immune functions with Chaga. Keep the caffeine under control. Scientifically proven and 3rd party lab-tested.",
  referrals: "In the spirit of the holidays, Four Sigmatic is giving “5-Bullet Friday” subscribers up to 44% OFF their popular mushroom coffee. Simply visit FourSigmatic.com/Tim44. In previous offers to this newsletter, Four Sigmatic products have sold out in less than 24 hours, so the early bird gets the worm.* FOR THE FEED",
)

files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704087/favolist/app%20assets/product%20images/tim%20ferris/Coffee/Four_Sigmatic_d05vjh.jpg")
]

logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678704087/favolist/app%20assets/product%20images/tim%20ferris/Coffee/Four_Sigmatic_Logo_pmks0m.jpg")

four_sigmatic.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
four_sigmatic.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
four_sigmatic.save!







# Create the product
collagen_peptides = Product.create(
  list: food_and_health_supplements,
  title: "Collagen Peptides Powder",
  price: 25.19,
  review: "This product was recommended to me by Amelia Boone, known as the 'Michael Jordan of obstacle course racing.' I've consumed gelatin for connective tissue repair in the past, but never stuck with it because of its texture. Amelia saved my palate and joints by recommending this type, which blends easily.",
  description: "DAILY WELLNESS: For your daily routine, 12 grams of unflavored collagen hydrolysate per serving. Types I and III hydrolyzed collagen provide the amino acids necessary to support hair, skin, nail, and joint health. HYDROLYZED FORMULA: An easy way to supplement collagen into your diet. Great Lakes Wellness Collagen Peptides Powder provides support for collagen production as we age. Good for men and women. QUICK DISSOLVE: Collagen Peptides Powder is sourced from grass-fed bovine. Easily digested and absorbed by the body quickly for maximum benefits. EASY TO USE: Daily Wellness Quick Dissolve Collagen Peptides is easy to add to hot or cold liquids. Perfect for coffee, tea, smoothies, or recipes. MADE FOR YOU: iGen Non-GMO Tested, Paleo-Friendly, KETO-Certified, Gluten-Free, No Preservatives, Glyphosate Free, Kosher, and Halal. No added dairy, sugars, or sweeteners. Flavorless and odorless.",
)

# Attach the photos
logo_url = "https://res.cloudinary.com/dncij7vr6/image/upload/v1678871417/favolist/app%20assets/product%20images/tim%20ferris/Collagen%20Peptides%20Powder/Great_Lakes_-_logo_i4itg4.jpg"
product_url = "https://res.cloudinary.com/dncij7vr6/image/upload/v1678871418/favolist/app%20assets/product%20images/tim%20ferris/Collagen%20Peptides%20Powder/Collagen_Peptides_Powder_zrdbad.jpg"

collagen_peptides.logo.attach(io: URI.open(logo_url), filename: "logo.jpg", content_type: "image/jpg")
collagen_peptides.photos.attach(io: URI.open(product_url), filename: "product.jpg", content_type: "image/jpg")





athletic_greens = Product.create(
  list: food_and_health_supplements,
  title: "Athletic Greens",
  price: 99,
  review: "I get asked all the time, “If you could only use one supplement, what would it be?” My answer is usually Athletic Greens, my all-in-one nutritional insurance. I recommended it in The 4-Hour Body in 2010 and did not get paid to do so. I do my best with nutrient-dense meals, of course, but AG further covers my bases with vitamins, minerals, and whole-food-sourced micronutrients that support gut health and the immune system.

  Right now, Athletic Greens is offering you their Vitamin D Liquid Formula free with your first subscription purchase—a vital nutrient for a strong immune system and strong bones.",
  description: "Comprehensive nutrition in one simple scoop. 75 high-quality vitamins, minerals, and whole-food sourced nutrients. Promotes gut health, supports immunity, boosts energy, and more*. Backed by our Scientific Advisory Board.",
  referrals: "Visit AthleticGreens.com/Tim to claim this special offer today and receive the free Vitamin D Liquid Formula (and five free travel packs) with your first subscription purchase! That’s up to a one-year supply of Vitamin D as added value when you try their delicious and comprehensive all-in-one daily greens product.",
  )

  files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942468/favolist/app%20assets/product%20images/tim%20ferris/Athletic%20Greens/Athletic_Greens_jhsubj.jpg")
  ]

  logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942468/favolist/app%20assets/product%20images/tim%20ferris/Athletic%20Greens/Athletic_Greens-logo_h00w1z.png")

  athletic_greens.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
  athletic_greens.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
  athletic_greens.save!



  pique = Product.create(
    list: food_and_health_supplements,
    title: "Pique Fermented Pu’er Tea Crystals",
    price: 52,
    review: "Pique’s fermented pu’er tea crystals have become my daily go-to. This rare type of naturally fermented tea is more concentrated in polyphenol antioxidants than any other tea—it supports focus and mental clarity, healthy digestion, metabolism and a healthy immune system. Their crystals are cold extracted, using only wild-harvested leaves from 250-year-old tea trees. Plus, they triple toxin screen for heavy metals, pesticides, and toxic mold—contaminants commonly found in tea. I also use the crystals for iced tea, which saves a ton of time and hassle.",
    description: "Pique’s fermented Pu’er Tea Crystals are an easy and convenient way to support a healthy digestion, metabolism and immune system. Made from naturally fermented, wild-harvested leaves from 250-year-old tea trees, these crystals are cold-extracted and free from heavy metals, pesticides and toxic mold.",
    referrals: "Pique is offering up to 20% off of their pu’er teas, exclusively to my listeners. To sweeten the deal even more, you’ll get a free sampler pack with 6 of their best-selling teas. Simply visit PiqueLife.com/Tim, and the discount will be automatically applied. They also offer a 30-day satisfaction guarantee, so your purchase is completely risk free. Just go to PiqueLife.com/Tim to learn more.",
    )

    files = [
    URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942775/favolist/app%20assets/product%20images/tim%20ferris/Pique/Pique_gccbue.jpg")
    ]

    logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942774/favolist/app%20assets/product%20images/tim%20ferris/Pique/Pique-logo_zblrrv.png")

    pique.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
    pique.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
    pique.save!




    wines = Product.create(
      list: food_and_health_supplements,
      title: "Dry Farm Wines",
      price: 171,
      review: "I’m a wine drinker, and I love a few glasses over meals with friends. That said, I hate hangovers. For the last few months, all of the wine in my house has been from Dry Farm Wines. Why? At least in my experience, their wine means more fun with fewer headaches. Dry Farm Wines only ships wines that meet very stringent criteria: sugar free (less than 0.15g per glass), lower alcohol (less than 12.5% alcohol), additive free (there are more than 70 FDA-approved wine-making additives), lower sulfites, organic, and produced by small family farms.

      All Dry Farm Wines are laboratory tested for purity standards by a certified, independent enologist, and all of their wines are also backed by a 100% Happiness Promise—they will either replace or refund any wine you do not love. Last but not least, I find delicious wines I never would have found otherwise. It’s a lot of fun.",
      description: "At Dry Farm Wines, we source wines according to our uncompromising criteria of farming and purity: ZERO SUGAR, ADDITIVE FREE, LOWER ALCOHOL, ORGANIC FARMING, LOW SULFITES, VEGAN, KETO & PALEO FRIENDLY.",
      referrals: "Dry Farm Wines has a special offer just for listeners of the podcast—an extra bottle in your first box for just one extra penny. Check out all the details at DryFarmWines.com/Tim.",
      )

      files = [
      URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942969/favolist/app%20assets/product%20images/tim%20ferris/Wines/Wines_mwfxgr.jpg")
      ]

      logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942969/favolist/app%20assets/product%20images/tim%20ferris/Wines/Wines-logo_ziqwlv.jpg")

      wines.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
      wines.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
      wines.save!



      maui_nui_venison = Product.create(
        list: food_and_health_supplements,
        title: "Maui Nui Venison",
        price: 239.2,
        review: "I’ve been eating Maui Nui Venison for the past two years, and there’s no going back. My pantry and freezers are full of it, and I restock every month. Why? (1) If I combine Maui Nui Venison with even a little exercise, I drop body fat unbelievably quickly. (2) It tastes delicious and isn’t gamey. (3) Ethically, I feel great about Maui Nui protein, as axis deer are an invasive species on Maui, where their population needs to be managed in order to protect vulnerable ecosystems.

        Harvested using stress-free methods, Maui Nui’s fresh venison is clean-tasting, tender, and one of the most nutrient-dense meats on the planet. Maui Nui is a nearly daily go-to for me, both as a supplement to my daily diet (with broth, jerky snacks, etc.) and through main courses (via their fresh-meat subscription program). I fell in love with this company so much that I ended up investing, which is a rarity.",
        description: "Don't miss your last chance to join the Maui Nui family as a subscriber. Our new and final iteration of fresh boxes is packed full of a variety of premium cuts, versatile family favorites, and custom add-ons.",
        referrals: "Tim Ferriss Show listeners can get 15% off on practically everything Maui Nui is offering by visiting MauiNuiVenison.com/Tim! Just use code TIM at checkout. This is the first discount they have done in more than a year, so you are getting something special, folks!"
        )

        files = [
        URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942732/favolist/app%20assets/product%20images/tim%20ferris/Maui%20Nui%20Venison/Maui_Nui_Venison_srvxbc.jpg")
        ]

        logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942731/favolist/app%20assets/product%20images/tim%20ferris/Maui%20Nui%20Venison/Maui_Nui_Venison-logo_zop55v.jpg")

        maui_nui_venison.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
        maui_nui_venison.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
        maui_nui_venison.save!



        ucan = Product.create(
          list: food_and_health_supplements,
          title: "UCAN",
          price: 69.95,
          review: "I was introduced to UCAN and its unique carbohydrate SuperStarch by my good friend—and listener favorite—Dr. Peter Attia, who said there is no carb in the world like it. I have since included it in my routine, using UCAN’s powders to power my workouts, and the bars make great snacks. Extensive scientific research and clinical trials have shown that SuperStarch provides a sustained release of energy to the body without spiking blood sugar. UCAN is the ideal way to source energy from a carbohydrate without the negatives associated with fast carbs, especially sugar.

          You avoid fatigue, hunger cravings, and loss of focus. Whether you’re an athlete working on managing your fitness or you need healthy, efficient calories to get you through your day, UCAN is an elegant energy solution.",
          description: "Designed to deliver a steady stream of energy to the mind and body, UCAN Energy Powders allow you to train longer at higher intensities with sustained energy. No sugar. No stimulants. Only clean, crash-free fuel to help you unlock next level performance.",
          referrals: "My listeners can save 25% on their first UCAN order by going to ucan.co and using promo code TIM. US orders will also be shipped for free.",
          )

          files = [
          URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942889/favolist/app%20assets/product%20images/tim%20ferris/UCAN/UCAN_v6ak4t.png")
          ]

          logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678942889/favolist/app%20assets/product%20images/tim%20ferris/UCAN/UCAN-logo_mc0uiy.png")

          ucan.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
          ucan.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
          ucan.save!





#################### TRAVEL PRODUCTS ######################

puts "creating travel pack products"

osprey_farpoint = Product.create(
  list: travel_gear,
  title: "Osprey Farpoint 40 L",
  price: 230,
  description: "The Osprey Farpoint 40 L is the perfect backpack for your next adventure. With a spacious main compartment and several smaller pockets, this backpack can hold all of your essentials while still being compact enough to carry on a plane. The lightweight and durable design make it ideal for backpacking, camping, or even just a weekend getaway.",

  review: "I recently took the Osprey Farpoint 40 L on a month-long backpacking trip through Europe and it was the perfect choice. The backpack is comfortable to wear, even with a full load, and the multiple compartments make it easy to stay organized. I also appreciated the compact size when traveling on trains and buses. Highly recommended!",
  referrals: "Get your own Osprey Farpoint 40 L backpack today and use it for your next adventure. You won't be disappointed.",
  )
  osprey_farpoint.save!



files = [
  URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956837/favolist/app%20assets/product%20images/more%20products/81tbav1HsSL._AC_SX679__kmunhy.jpg"),
]
logo = URI.open("https://res.cloudinary.com/dncij7vr6/image/upload/v1678956853/favolist/app%20assets/product%20images/more%20products/7f23268b-ee6a-4c3b-a08a-03653b2880e1_vfajum.jpg")
osprey_farpoint.photos.attach(files.map { |f| { io: f, filename: "image.jpg", content_type: "image/jpg" } })
osprey_farpoint.logo.attach(io: logo, filename: "image.jpg", content_type: "image/jpg")
osprey_farpoint.save!



#Nomatic Backpack
nomatic = Product.create(
  list: on_the_road_list,
  title: "NOMATIC Backpack",
  price: 250,
  review: "Stylish af bag I take with me every day.
  Usually I carry my kindl, nextstand, keyboard, mouse, journal and other items in it. When travelling it also accomodates the items I don’t want to put in the checked baggage. Large enough for day trips: can carry a big bottle, 16-inch macbook pro, ipad, a set of clothing for 2 days (bar trousers) and is just my little baby.
  Thank you brother for this surprise Christmas gift which I told you to get me after doing my usual 4 hours of research to find the best. Once again, this brand appears in every “Top 5” blog post about laptop bags. I’ve had it for four years now and it’s basically in the same shape as when I bought it. The design buffers shock so that my laptop survived bump here and there.
  I just love this thing. Check it out for yourself. Ah yes, and it’s water resistant.",

  description: "The NOMATIC Travel Pack was designed for everyday use and for those shorter 1-3 day trips. It’s made with durable, water-resistant materials and YKK zippers. Expanding 50%, this bag is slim but expands when you need to pack more. The patent pending strap system allows you to go from backpack to briefcase carry for those times when you need to look more professional.
  The full perimeter zipper, magnetic water bottle pockets, RFID safe storage, and hidden pockets are just a few of the 20+ noteworthy features that make the Travel Pack the most functional travel pack ever! On top of being packed with incredible functionality, the NOMATIC Travel Pack has a sleek minimalist design and gives you confidence for your life on the move.
  Includes
  Sunglasses Case
  Retractable Key-Leash",

  referrals: "Use code 'NOMAD' and you get 15% off your first purchase. I also get 15% off my next purchase!
"
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


puts "SEEDING COMPLETE!"
