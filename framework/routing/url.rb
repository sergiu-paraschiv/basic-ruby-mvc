module BRMVC
  class URL

    def initialize(route, params = {})
      @route = route.to_s

      params.each { |name, value| @route.gsub! ':' + name.to_s, value.to_s }
    end

    def to_s
      @route
    end

  end
end
