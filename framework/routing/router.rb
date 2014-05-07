module BRMVC
  class Router
    def initialize
      @routes = []

      routes
    end

    def routes
    end

    def add_route(method, uri, action)
      route = Route.new(:get, uri, action)
      @routes << route

      route
    end

    def get(uri, action)
      add_route(__method__, uri, action)
    end

    def post(uri, action)
      add_route(__method__, uri, action)
    end

    def put(uri, action)
      add_route(__method__, uri, action)
    end

    def delete(uri, action)
      add_route(__method__, uri, action)
    end

    def handle(request)
      route = @routes.find do |route| 
        request.method == route.method and request.uri =~ route.uri_regexp
      end

      return exception(404) unless route

      params = route.uri_regexp.match(request.uri).captures
      eval(route.controller).new.send(route.action, *params)
    end

    def exception(type)
      html = File.open(File.expand_path('../../../app/views/exceptions/' + type.to_s + '.html', __FILE__)).read;
      [type, {'Content-Type' => 'text/html'}, [html]]
    end
  end
end