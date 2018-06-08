User.create!(name: "ADMIN",
  email: "admin@abc.com",
  password: "zxcvbn",
  password_confirmation: "zxcvbn")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "zxcvbn"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password)
end
users = User.order(:created_at).take(10)
50.times do
  title = Faker::SiliconValley.invention
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(content: content,
    title: title) }
end
