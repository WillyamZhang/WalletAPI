# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'digest'

User.destroy_all
User.create!([
  { email: "user1@example.com", password_digest: Digest::SHA256.hexdigest("password") },
  { email: "user2@example.com", password_digest: Digest::SHA256.hexdigest("password") },
  { email: "user3@example.com", password_digest: Digest::SHA256.hexdigest("password") },
  { email: "user4@example.com", password_digest: Digest::SHA256.hexdigest("password") },
  { email: "user5@example.com", password_digest: Digest::SHA256.hexdigest("password") }
])

puts "5 users created with SHA256-hashed passwords!"

Team.destroy_all
Team.create!([
  { name: "Team1", password_digest: Digest::SHA256.hexdigest("password") },
  { name: "Team2", password_digest: Digest::SHA256.hexdigest("password") },
  { name: "Team3", password_digest: Digest::SHA256.hexdigest("password") },
  { name: "Team4", password_digest: Digest::SHA256.hexdigest("password") },
  { name: "Team5", password_digest: Digest::SHA256.hexdigest("password") }
])

puts "5 team created with SHA256-hashed passwords!"

Stock.destroy_all
Stock.create!([
  { symbol: "Stock1", password_digest: Digest::SHA256.hexdigest("password") },
  { symbol: "Stock2", password_digest: Digest::SHA256.hexdigest("password") },
  { symbol: "Stock3", password_digest: Digest::SHA256.hexdigest("password") },
  { symbol: "Stock4", password_digest: Digest::SHA256.hexdigest("password") },
  { symbol: "Stock5", password_digest: Digest::SHA256.hexdigest("password") }
])

puts "5 Stock created with SHA256-hashed passwords!"