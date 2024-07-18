# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { email: 'user1@example.com', password: 'password1', first_name: 'Jan', last_name: 'Kowalski', role: :admin },
  { email: 'user2@example.com', password: 'password2', first_name: 'Anna', last_name: 'Nowak', role: :boss },
  { email: 'user3@example.com', password: 'password3', first_name: 'Piotr', last_name: 'Wiśniewski', role: :normal },
  { email: 'user4@example.com', password: 'password4', first_name: 'Katarzyna', last_name: 'Kozłowska', role: :normal },
  { email: 'user5@example.com', password: 'password5', first_name: 'Marcin', last_name: 'Jankowski', role: :normal },
  { email: 'user6@example.com', password: 'password6', first_name: 'Agnieszka', last_name: 'Mazur', role: :normal },
  { email: 'user7@example.com', password: 'password7', first_name: 'Michał', last_name: 'Kwiatkowski', role: :normal },
  { email: 'user8@example.com', password: 'password8', first_name: 'Magdalena', last_name: 'Wojciechowska', role: :normal }
]

cars = [
  { brand: "Toyota", model: "Corolla", picture: "corolla.jpg", run: 15000.0, fuel_consumption: 6.5 },
  { brand: "Ford", model: "Focus", picture: "focus.jpg", run: 22000.0, fuel_consumption: 7.0 },
  { brand: "Honda", model: "Civic", picture: "civic.jpg", run: 18000.0, fuel_consumption: 5.5 }
]




unless User.exists?
  users.each do |user|
    User.create!(user)
  end
end

unless Car.exists?


  cars.each do |car|
    Car.create!(car)
  end
end

unless Trip.exists?
  created_users = users.map do |user|
    User.find_or_create_by!(email: user[:email]) do |u|
      u.password = user[:password]
      u.first_name = user[:first_name]
      u.last_name = user[:last_name]
      u.role = user[:role]
    end
  end

  created_cars = cars.map do |car|
    Car.find_or_create_by!(model: car[:model]) do |c|
      c.brand = car[:brand]
      c.picture = car[:picture]
      c.run = car[:run]
      c.fuel_consumption = car[:fuel_consumption]
    end
  end

  trips = [
    { from: "Warszawa", to: "Kraków", pitstop: "Kielce", distance: 300, date_beginning: Date.today, date_end: Date.today + 1, user: created_users[3], car: created_cars[0] },
    { from: "Gdańsk", to: "Wrocław", pitstop: "Łódź", distance: 500, date_beginning: Date.today + 2, date_end: Date.today + 3, user: created_users[1], car: created_cars[1] },
    { from: "Szczecin", to: "Poznań", pitstop: "Gorzów Wielkopolski", distance: 250, date_beginning: Date.today + 4, date_end: Date.today + 5, user: created_users[2], car: created_cars[2] }
  ]

  trips.each do |trip|
    Trip.create!(trip)
  end
end