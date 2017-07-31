class Request
  class << self
    def where(resource_path, query = {}, options = {})
      json_body, status = get_json(resource_path, query)
      json_body if status == 200
    end

    # def get

    # end

    # def search

    # end

    def get_json(root_path, query)
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      path = query.empty?? root_path : "#{root_path}?#{query_string}"
      response = api.get(path)
      [JSON.parse(response.body), response.status]
    end

    def api
      Connection.api
    end
  end
end
