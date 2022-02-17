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
movies.each do |movie|
  # Destroy any existing showtimes - we'll recreate them!
  movie.showtimes.destroy_all

  theatres.each do |theatre|
    4.times do |n|
      # Lets assume that each movie is 2 hours long
      offset = (n + 1) * 2


      Showtime.create!(
        starts_at: offset.hours.from_now,
        theatre: theatre,
        movie: movie,
      )
    end
  end
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
