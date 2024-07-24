# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = 30.times.map do |i|
  {
    email: "user#{i+1}@example.com",
    password: "password#{i+1}",
    first_name: "FirstName#{i+1}",
    last_name: "LastName#{i+1}",
    role: i == 0 ? :admin : i == 1 ? :boss : :normal
  }
end

cars = 30.times.map do |i|
  {
    brand: ["Toyota", "Ford", "Honda", "Porshe", "Hunday", "Volkswagen"].sample,
    model: "Model#{i+1}",
    picture: "picture#{i+1}.jpg",
    run: rand(10000..30000).to_f,
    fuel_consumption: rand(5.0..8.0)
  }
end

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

  trips = 30.times.map do |i|
    {
      from: ["Warszawa", "Gdańsk", "Szczecin", "Łódź", "Grodzisk", "Gdańsk"].sample,
      to: ["Kraków", "Wrocław", "Poznań", "Opole", "Zgierz", "Opoczno"].sample,
      pitstop: ["Kielce", "Łódź", "Gorzów Wielkopolski", "Radom", "Białystok"].sample,
      distance: rand(50..600),
      date_beginning: Date.today + i,
      date_end: Date.today + i,
      user: created_users.sample,
      car: created_cars.sample
    }
  end

  trips.each do |trip|
    Trip.create!(trip)
  end
end