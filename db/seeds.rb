User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             birthday: "18/10/1980",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  birthday = "18/10/1980"
  password = "password"
  User.create!(name:  name,
               email: email,
               birthday: birthday,
               password:              password,
               password_confirmation: password)
end
users = User.order(:created_at).take(6)
50.times do
  title = "this is title"
  content = "this is content"
  users.each { |user| user.entries.create!(content: content, entry_title: title) }
end
# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }