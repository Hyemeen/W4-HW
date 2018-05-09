require 'faker'

namespace :signin do

  desc "ALL"
  task all: [:twenty, :thirty, :forty, :fifty]

  desc "twenties signed in"
  task :twenty => :environment do
    (1..20).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(20, 29), email: Faker::Internet.email
    end
  end

  desc "thirties signed in"
  task :thirty => :environment do
    (1..10).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(30, 39), email: Faker::Internet.email
    end
  end

  desc "forties signed in"
  task :forty => :environment do
    (1..5).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(40, 49), email: Faker::Internet.email
    end
  end

  desc "fifties signed in"
  task :fifty => :environment do
    (1..5).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(50, 59), email: Faker::Internet.email
    end
  end
end