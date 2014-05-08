module BRMVC
  class Redirect < Response

    def initialize(path)
      super nil, 301, {'Location' => path.to_s}
    end

  end
end
