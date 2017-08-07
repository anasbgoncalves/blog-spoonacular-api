class RecipesController < ApplicationController

  def index
    @tag = query.fetch(:tags, 'all')
    @recipes = Recipe.random(query)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private
  def query
    params.fetch(:query, {})
  end
end
