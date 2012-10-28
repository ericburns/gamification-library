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

User.destroy_all
CSV.foreach("db/user_seed.csv") do | row |
  level = Level.find_by_xp_to_next_level(row[0])
  level.users.create!({ username: row[1],
                        level_id: level.id,
                        xp: row[2] })
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
