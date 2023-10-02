puts 'creating fake users'

10.times do |i|
  puts 'creating user'

  user = User.create(
    name:      Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday:  Faker::Date.birthday(min_age: 18, max_age: 30),
    email:     "user_#{i + 1}@autumn.pe",
    password:  'autumn23',
    phone:     Faker::PhoneNumber.phone_number_with_country_code
  )

  puts "User created: #{user.fullname}"
end

puts 'creating fake admin users'

2.times do |i|
  puts 'creating admin'

  user = User.create(
    name:      Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday:  Faker::Date.birthday(min_age: 18, max_age: 30),
    email:     "admin_#{i + 1}@autumn.pe",
    password:  "admin-autumn23",
    phone:     Faker::PhoneNumber.phone_number_with_country_code,
    admin:     true
  )

  puts "Admin created: #{user.fullname}"
end
