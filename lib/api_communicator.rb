
require 'pry'
require 'rest-client'
require 'json'


def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')   #make the web request
  response_hash = JSON.parse(response_string)
  results = response_hash["results"]

  # iterate over the response hash to find the collection of `films` for the given `character`

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

#.............................. new method

def get_movie_data
  response_string = RestClient.get('http://www.swapi.co/api/films/')   #make the web request
  movie_hash = JSON.parse(response_string)
  results_movies = movie_hash["results"]
end


def get_character_names(movie_name)
 results_movies = get_movie_data
  results_movies.each do |movie_info|
    if movie_info["title"] == movie_name
    return movie_info["characters"]
   end
 end
end

def display_data(movie_name)
  character_data = get_character_names(movie_name)

  character_data.each_with_index do |character, index|
    response_string = RestClient.get(character)
      character_hash = JSON.parse(response_string)
    puts "#{index +1}. #{character_hash["name"]}"
  end
end

display_data("A New Hope")



# 1. get data from the IP :)
# 2. parse data into json :)
# 3. save the film data :)

# 4. get character names from movie hash using the movie name :)

# 5. puts out the character data into a list
# 6. catering for inconsistencies in data inputs vs API data
