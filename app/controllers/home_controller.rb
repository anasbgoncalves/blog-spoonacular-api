class HomeController < ActionController::Base

  def index
    @recipes = Recipe.random
  end
end
