class RecipesController < ApplicationController

  def index
    @tag = query.fetch(:tags, 'all')
    @recipes, @errors = Spoonacular::Recipe.random(query, clear_cache)
  end

  def show
    @recipe = Spoonacular::Recipe.find(params[:id], clear_cache)
  end

  private
  def query
    params.fetch(:query, {})
  end

  def clear_cache
    params.fetch(:clear_cache, false)
  end
end
