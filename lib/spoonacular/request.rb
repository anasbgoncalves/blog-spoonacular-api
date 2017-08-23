class Request
  class << self
    def where(resource_path, cache, query = {}, options = {})
      response, status = get_json(resource_path, cache, query)
      status == 200 ? response : errors(response)
    end

    def get(id, cache)
      response, status = get_json(id, cache)
      status == 200 ? response : errors(response)
    end

    def errors(response)
      error = { errors: { status: response["status"], message: response["message"] } }
      response.merge(error)
    end

    def get_json(root_path, cache, query = {})
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      path = query.empty?? root_path : "#{root_path}?#{query_string}"
      response =  Rails.cache.fetch(path, expires_in: cache[:expires_in], force: cache[:force]) do
        api.get(path)
      end
      [JSON.parse(response.body), response.status]
    end

    def api
      Connection.api
    end
  end
end
