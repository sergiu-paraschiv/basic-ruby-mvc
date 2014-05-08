module BRMVC
  class Request
    attr_accessor :method, :uri, :query, :body, :router

    def initialize(request, router)
      @method = request.request_method.downcase.to_sym
      @uri = request.path
      @query = request.params
      @body = request.body
      @router = router
    end

    def [](key)
      @query[key]
    end

    def []=(key, value)
      @query[key] = value
    end

  end
end
