class RecipesController < ApplicationController

  def index
    @tag = query.fetch(:tags, 'all')
    @recipes, @errors = Spoonacular::Recipe.random(query)
  end

  def show
    @recipe = Spoonacular::Recipe.find(params[:id])
  end

  private
  def query
    params.fetch(:query, {})
  end
end
