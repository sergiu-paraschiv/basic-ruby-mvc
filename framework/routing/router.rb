module BRMVC
  class Router

    ALLOWED_HTTP_METHODS = [:get, :post, :put, :delete, :options]

    def initialize
      @routes = []
      @group_args = {
        :paths => [],
        :controllers => []
      }

      routes
    end

    def routes
    end

    def add_route(method, uri, controller, action = nil)
      if action.nil?
        action = controller
        controller = nil
      end

      uri = @group_args[:paths].join('') + uri

      if @group_args[:controllers].length > 0
        controllers = @group_args[:controllers] + [controller]
        controllers.compact!

        controller = eval(controllers.join('::'))
      end

      route = Route.new(method, uri, controller, action)
      @routes << route

      route
    end

    def add_group(*args, &block)
      group_has_path = args.length > 0 and args[0].is_a? String
      group_has_controller = args.length > 1

      if group_has_path
        @group_args[:paths] << args[0]
      end

      if group_has_controller
        @group_args[:controllers] << args[1]
      end

      yield(block)

      if group_has_path
        @group_args[:paths] .pop
      end

      if group_has_controller
        @group_args[:controllers].pop
      end

    end

    def allowed_http_method?(method)
      ALLOWED_HTTP_METHODS.include?(method)
    end

    def respond_to?(method, include_private = false)
      allowed_http_method?(method) || super(method, include_private)
    end

    def method_missing(method, *args, &block)
      return add_route(method, *args) if allowed_http_method?(method)
      return add_group(*args, &block) if method == :group

      super(method, *args, &block)
    end

    def handle(request)
      route = @routes.find do |route|
        request.method == route.method and request.uri =~ route.uri_regexp
      end

      return exception(404).to_a unless route

      params = route.uri_regexp.match(request.uri).captures

      params.compact!

      call_action route, request, params
    end

    def call_action(route, request, params)
      response = route.controller.new.send(route.action, request, *params)

      response = Response.new(response.to_s) unless response.is_a? Response

      response.to_a
    end

    def url(route_name, params)
      route = @routes.find { |route| route.name == route_name }

      return nil unless route

      URL::new route.uri, params
    end

    def exception(type)
      html = File.open(File.expand_path('../../../app/views/exceptions/' + type.to_s + '.html', __FILE__)).read

      Response.new html, type
    end
  end
end
