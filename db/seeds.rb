# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Seed data for the authors table

Author.destroy_all
Book.destroy_all
User.destroy_all

puts "Seeding Authors...."

Author.create([
  { first_name: 'J.K.', last_name: 'Rowling', age: 56 },
  { first_name: 'Stephen', last_name: 'King', age: 74 },
  { first_name: 'Toni', last_name: 'Morrison', age: 88 },
  { first_name: 'George R.R.', last_name: 'Martin', age: 73 }
])

puts "Seeding Books...."

# Seed data for the books table
Book.create([
  { title: 'Harry Potter and the Philosopher\'s Stone', author_id: 1 },
  { title: 'The Shining', author_id: 2 },
  { title: 'Beloved', author_id: 3 },
  { title: 'A Game of Thrones', author_id: 4 },
  { title: 'Harry Potter and the Chamber of Secrets', author_id: 1 },
  { title: 'The Stand', author_id: 2 },
  { title: 'Song of Solomon', author_id: 3 },
  { title: 'A Clash of Kings', author_id: 4 }
])

puts "Seeding Users...."

# Seed data for the users table
User.create([
  { username: 'admin', password: 'password123' }
])
