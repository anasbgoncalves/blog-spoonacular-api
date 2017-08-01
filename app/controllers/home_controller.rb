class HomeController < ApplicationController

  def index
    @recipes = Recipe.random(query)
  end

  private
  def query
    params.fetch(:query, {})
  end
end
