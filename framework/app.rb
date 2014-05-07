module BRMVC
  class App
    def initialize(appNamespace)
      @router = eval(appNamespace.to_s)::Router.new
    end

    def call(env)
      @router.handle Request.new(env)
    end
  end
end