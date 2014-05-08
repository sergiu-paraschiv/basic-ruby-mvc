module BRMVC
  class App
    def initialize(appNamespace)
      @router = eval(appNamespace.to_s)::Router.new
    end

    def call(env)
      @router.handle Request.new(Rack::Request.new(env), @router)
    end
  end
end
