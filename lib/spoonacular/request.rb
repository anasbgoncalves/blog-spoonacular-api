class Request
  class << self
    def where(resource_path, query = {}, options = {}, clear_cache)
      get_json(resource_path, query, clear_cache)
    end

    def get(id, clear_cache)
      get_json(id, {}, clear_cache)
    end

    def get_json(root_path, query = {}, clear_cache = false)
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      path = query.empty?? root_path : "#{root_path}?#{query_string}"
      response = Rails.cache.fetch(path, expires_in: 30.minutes, force: clear_cache) do
        api.get(path)
      end
      [JSON.parse(response.body), response.status]
    end

    def api
      Connection.api
    end
  end
end
