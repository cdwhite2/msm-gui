class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
    new_actor = Actor.new
    new_actor.name = params.fetch("query_name")
    new_actor.dob = params.fetch("query_dob")
    new_actor.bio = params.fetch("query_bio")
    new_actor.image = params.fetch("query_image")
    new_actor.save

    redirect_to("/actors")
  end

  def modify
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    change_actor = matching_actors.at(0)
    change_actor.name = params.fetch("query_name")
    change_actor.dob = params.fetch("query_dob")
    change_actor.bio = params.fetch("query_bio")
    change_actor.image = params.fetch("query_image")
    change_actor.save

    redirect_to("/actors/#{change_actor.id}")
  end

  def delete
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    delete_actor = matching_actors.at(0)
    delete_actor.delete

    redirect_to("/actors")
  end
end
