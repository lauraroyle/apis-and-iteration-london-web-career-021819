
require 'pry'
require 'rest-client'
require 'json'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  results = response_hash["results"]

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  films = nil

  results.each do |character|
    if character_name == character["name"]
      films = character["films"]
    end

  end

  if films
    film_data = films.collect do |film_api|
      film_response_string = RestClient.get(film_api)
      film_response_hash = JSON.parse(film_response_string)
      film_response_hash
    end
  else
    film_data = nil
  end

  film_data

end
def print_movies(films)
  if films
    films.each_with_index do |film, index|
      puts "#{index + 1}. #{film["title"]}"
    end
  else
    puts "Do you even like Star Wars?"
  end

end
def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

