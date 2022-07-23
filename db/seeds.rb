# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
Comment.destroy_all
User.destroy_all

# Admin User
PASSWORD = "123"
super_user = User.create(
  name: "Admin",
  email: "admin@user.com",
  password: PASSWORD,
  is_admin: true
)

10.times do 
  name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    name: first_name,
    email: "#{name.downcase}@#{last_name.downcase}.com",
    password: PASSWORD
  )
end

users = User.all

50.times do
    created_at = Faker::Date.backward(days:365 * 5)
    q = Post.create(
      title: Faker::Hacker.say_something_smart,
      body: Faker::Lorem.paragraph_by_chars(number: 55, supplemental: false),
      created_at: created_at,
      updated_at: created_at,
      user: users.sample
    )
    if q.valid?
      rand(1..3).times do
        Comment.create(body: Faker::Hacker.say_something_smart, post:q, user: users.sample)
      end
    end
  end

  posts = Post.all
  comments = Comment.all

puts Cowsay.say("Generated #{posts.count} posts", :frogs)
puts Cowsay.say("Generated #{comments.count} comments", :dragon)
puts Cowsay.say("Generated #{users.count} users", :cow)

# To run this file use command: rails db:seed