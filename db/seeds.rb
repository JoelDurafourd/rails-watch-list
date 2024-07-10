# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'


Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

# the Le Wagon copy of the API
url = 'http://tmdb.lewagon.com/movie/top_rated'
response = JSON.parse(URI.open(url).read)

response['results'].each do |movie_hash|
  # create an instance with the hash
  Movie.create!(
    poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
    rating: movie_hash['vote_average'],
    title: movie_hash['title'],
    overview: movie_hash['overview']
  )
end
