User.create!(name: "ADMIN",
  email: "admin@abc.com",
  password: "zxcvbn",
  password_confirmation: "zxcvbn")

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "zxcvbn"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password)
end
users = User.order(:created_at).take(6)
50.times do
  title = Faker::SiliconValley.invention
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(title: title, content: content) }
end
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


