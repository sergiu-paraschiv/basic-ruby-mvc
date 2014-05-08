module BRMVC
  class Response

    DEFAULT_HEADERS = {
      'Content-Type' => 'text/html'
    }

    attr_accessor :content, :status, :headers

    def initialize(content, status = 200, headers = {})

      DEFAULT_HEADERS.each do |name, value|
        unless headers.has_key? name
          headers[name] = value
        end
      end

      @content = content
      @status = status
      @headers = headers
    end

    def to_a
      [@status, @headers, [@content]]
    end

  end
end
