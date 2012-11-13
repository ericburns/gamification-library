# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
require 'csv'

Level.destroy_all
CSV.foreach("db/level_seed.csv") do | row |
  Level.create!({ xp_to_next_level: row[0] })
  puts "level with #{row[0]} created"
end

Game.destroy_all
CSV.foreach("db/game_seed.csv") do | row |
  Game.create!({ gamename: row[0], 
                 description: row[1],
                 unit: row[2] })

  puts "Game #{row[0]} created!"
end

User.destroy_all
CSV.foreach("db/user_seed.csv") do | row |
  level = Level.find_by_xp_to_next_level(row[0])
  game = Game.find_by_gamename(row[4])
  level.users.create!({ username: row[1],
                        level_id: level.id,
                        xp: row[2],
                        password: row[3], 
                        game_id: game.id })
  puts "#{row[1]}, created!"
end

Friendship.destroy_all
CSV.foreach("db/friendship_seed.csv") do | row |
  user = User.find_by_username(row[0])
  friend = User.find_by_username(row[1])
  user.friendships.create!({ user_id: user.id,
                             friend_id: friend.id})
  puts "#{user.username} is now friends with #{friend.username}"
end

Badge.destroy_all
CSV.foreach("db/badge_seed.csv") do | row |
  Badge.create!({ badge_name: row[0],
                  badge_image: row[1],
                  badge_info: row[2],
                  awarded_at: row[3] })
  puts "#{row[0]} created!"
end

Inventory.destroy_all
CSV.foreach("db/inventory_seed.csv") do | row |
  user = User.find_by_username(row[0])
  badge = Badge.find_by_badge_name(row[1])
  badge.inventories.create!({ user_id: user.id,
                             amount: row[2] })
  puts "inventory for #{user.username} created!"
end

Email.destroy_all
CSV.foreach("db/email_seed.csv") do | row |
  user = User.find_by_username(row[0])
  user.emails.create!({ email: row[1] })

  puts "email for #{user} created!"
end


