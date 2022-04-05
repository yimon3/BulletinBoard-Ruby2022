# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Post.create!([{
    title: "Cooking",
    description: "The best cooking",
    status: 1,
    created_user_id: 1,
    updated_user_id:1,
    deleted_user_id: 0,
    user_id: 1
  },
  {
    title: "Swimming",
    description: "The best Swimming",
    status: 1,
    created_user_id: 1,
    updated_user_id:1,
    deleted_user_id: 0,
    user_id: 1
  },
  {
    title: "Crochet",
    description: "The Detail testing",
    status: 1,
    created_user_id: 1,
    updated_user_id:1,
    deleted_user_id: 0,
    user_id: 1
  }])

  p "Created #{Post.count} posts"