# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Provider.destroy_all

Procedure.destroy_all

Review.destroy_all


puts "creating providers"
15.times do 

  provider = Provider.new(email: Faker::Internet.safe_email,
                  name: Faker::Company.name,
                  password: "password")
  provider.save!
end