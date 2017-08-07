require 'faraday'
require 'json'

class Connection
  BASE = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com'

  def self.api
    @api ||= Faraday.new(url: BASE) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['X-Mashape-Key'] = ENV['MASHAPE_KEY']
    end
  end
end
