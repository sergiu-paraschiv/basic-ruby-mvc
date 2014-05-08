module BRMVC
  class Route

    COMON_PARAM_PATTERNS = {
      :number => /\-?\d+(?:\.\d+)?/,
      :integer => /\-?\d+/,
      :alphanum => /[0-9a-zA-Z]+/
    }

    OPTIONAL_PARAM_SEPARATORS = %w{/ , ; . : - _ ~ + * = @ |}

    attr_accessor :method, :uri, :controller, :action, :name

    def uri_regexp
      Regexp.new @uri_regexp
    end

    def initialize(method, uri, controller, action)
      @method = method
      @uri = uri
      @controller = controller
      @action = action
      @uri_regexp = '\A' + uri + '\z'
      @name = nil
    end

    def where_one(param, pattern)
      if COMON_PARAM_PATTERNS.has_key? pattern
        pattern = COMON_PARAM_PATTERNS[pattern]
      end

      regex_part = '(' + pattern.to_s + ')'
      param = ':' + param.to_s

      if param.to_s[-1] == '?'
        regex_part << '?'

        param_pos = @uri_regexp.index(param)
        pre_param_char = @uri_regexp[param_pos - 1]

        if OPTIONAL_PARAM_SEPARATORS.include? pre_param_char
          param = pre_param_char + param
          regex_part = pre_param_char + '?' + regex_part
        end
      end

      @uri_regexp.gsub!(param, regex_part)
    end

    def where(param, pattern = nil)
      if pattern.nil? and param.is_a? Hash
        param.each { |name, pattern| where_one name, pattern }
      else
        where_one param, pattern
      end

      self
    end

    def as(name)
      @name = name
    end

  end
end

