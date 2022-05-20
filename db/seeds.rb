# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "open-uri"

Movie.destroy_all

FILMS_URL = "http://tmdb.lewagon.com/movie/top_rated"

movie_ids = JSON.parse(URI.open(FILMS_URL).read)["results"]
# p movie_ids

movie_ids.each do |movie|
  poster_base_url = "https://image.tmdb.org/t/p/original"
  film_image = URI.open("#{poster_base_url}#{movie["poster_path"]}")
  new_movie = Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    rating: movie["vote_average"]
  )
  new_movie.photo.attach(io: film_image, filename: "#{movie["title"]}.jpg", content_type: 'image/jpg')
end


# movie_ids.take(10).each do |id|
#   movie_db_film = JSON.parse(RestClient.get())
#   movie = Movie.new(
#     title: movie_db_film["title"],
#     overview: movie_db_film["overview"],
#     poster_url: movie_db_film["poster_path"],
#     rating: movie_db_film["vote_average"]
#   )
#   movie.save
#   puts "[#{movie.rating}] #{movie.title} - #{movie.poster_url} - #{movie.overview}"
# end
