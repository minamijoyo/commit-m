# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#CSV.foreach('db/commits.txt') do |row|
#  Commit.create(:repo_full_name => row[0], :sha => row[1], :message => row[2])
#end

# commit message can contain character ,
# so read line and split by myself.
open('db/commits.txt') do |file|
  file.each do |line|
    repo_full_name, sha, *message_array = line.split(',').map(&:strip)
    message = message_array.join(', ')
    Commit.create(:repo_full_name => repo_full_name,
                  :sha => sha,
                  :message => message)
  end
end
