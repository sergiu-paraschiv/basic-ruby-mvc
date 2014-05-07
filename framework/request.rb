module BRMVC
  class Request
    attr_accessor :method, :uri, :uri_regexp

    def initialize(env)
      @method = env['REQUEST_METHOD'].downcase.to_sym
      @uri = env['REQUEST_PATH']
    end
  end
end