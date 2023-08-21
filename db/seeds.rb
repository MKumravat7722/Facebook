# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 10.times do |i|
  
#     User.create(
#     first_name: 'mohit'"#{i}",
#     last_name:'kumravat',
#     email:'mohit'"#{i}"'@gmail.com',
#     username:'mohit@12'"#{i}",
#     password_digest:'Mohit@1234',
#     profile_picture: 'mk'
#     )
    
#     end  

# first_name: 'mohit'"#{i}",
#     last_name:'kumravat',
#     email:'mohit'"#{i}"'@gmail.com',
#     username:'mohit@12'"#{i}",
#     password_digest:'Mohit@1234',
#     profile_picture: 'mk'
  user2=User.find(2)
  10.times do |i|
    user2.posts.create(caption: "At Home#{i} ",image: "Post#{i}" ,user_id:user2.id)
  end

