class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def insert
    new_movie = Movie.new
    new_movie.title = params.fetch("query_title")
    new_movie.year = params.fetch("query_year")
    new_movie.duration = params.fetch("query_duration")
    new_movie.description = params.fetch("query_description")
    new_movie.image = params.fetch("query_image")
    new_movie.director_id = params.fetch("query_director_id")
    new_movie.save

    redirect_to("/movies")
  end

  def modify
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    change_movie = matching_movies.at(0)
    change_movie.title = params.fetch("query_title")
    change_movie.year = params.fetch("query_year")
    change_movie.duration = params.fetch("query_duration")
    change_movie.description = params.fetch("query_description")
    change_movie.image = params.fetch("query_image")
    change_movie.director_id = params.fetch("query_director_id")
    change_movie.save

    redirect_to("/movies/#{change_movie.id}")
  end

  def delete
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    delete_movie = matching_movies.at(0)
    delete_movie.delete

    redirect_to("/movies")
  end
end
