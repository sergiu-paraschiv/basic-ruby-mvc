module BRMVC
  class Route
    COMON_PARAM_PATTERNS = { 
      :number => /\-?\d+(?:\.\d+)?/, 
      :integer => /\-?\d+/, 
      :alphanum => /[0-9a-zA-Z]+/ 
    }

    attr_accessor :method, :uri, :controller, :action, :params

    def initialize(method, uri, action)
      @method = method
      @uri = uri

      action = action.split '.'

      @controller = action[0]
      @action = action[1]
      @params = {}
    end

    def uri_regexp
      pattern = '\A' + @uri + '\z'
      @params.each do |param, param_pattern|
        pattern.gsub!(':' + param.to_s, '(' + param_pattern.to_s + ')')
      end

      Regexp.new pattern
    end

    def where(param, pattern)
      if COMON_PARAM_PATTERNS.has_key? pattern
        pattern = COMON_PARAM_PATTERNS[pattern]
      end

      @params[param] = pattern
    end

  end
end