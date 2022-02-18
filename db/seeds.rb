# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating Movies"
movies = [
  Movie.find_or_create_by!(name: "The Matrix"),
  Movie.find_or_create_by!(name: "Ghostbusters"),
  Movie.find_or_create_by!(name: "Spider-Man 12"),
]

puts "Creating Theatres"
theatres = [
  Theatre.find_or_create_by!(name: "Cineplex One"),
  Theatre.find_or_create_by!(name: "Cineplex Two"),
  Theatre.find_or_create_by!(name: "Cineplex Three"),
]

# Create Seats for Theatres
puts "Creating Seats for Theatres"
theatres.each do |theatre|
  # Destroy any existing seats - we'll recreate them!
  theatre.seats.destroy_all

  30.times do |n|
    Seat.create!(theatre: theatre, number: "#{n + 1}")
  end
end

# Create Showtimes for Theatres and Movies
puts "Creating Showtimes for Theatres and Movies"
movies.each_with_index do |movie, index|
  # Destroy any existing showtimes - we'll recreate them!
  movie.showtimes.destroy_all

  first_day = rand(1..3)
  second_day = rand(4..6)

  first_theatre, second_theatre = theatres.sample(2)

  # Ensures that we're creating unique start times
  offset = (index * 2).hours

  Showtime.create!(
    starts_at: first_day.days.from_now.beginning_of_day + 12.hours + offset,
    theatre: first_theatre,
    movie: movie
  )

  Showtime.create!(
    starts_at: second_day.days.from_now.beginning_of_day + 17.hours + offset,
    theatre: second_theatre,
    movie: movie
  )
end

# Create Tickets for all seats we just created
movies.each do |movie|
  movie.reload.showtimes.each do |showtime|
    showtime.theatre.seats.each do |seat|
      Ticket.create!(
        status: :available,
        showtime: showtime,
        seat: seat,
      )
    end
  end
end
