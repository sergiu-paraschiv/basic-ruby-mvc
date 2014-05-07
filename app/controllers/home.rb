module MyApp
  class HomeController
    def index
      [200, {'Content-Type' => 'text/html'}, ['index']]
    end

    def test
      [200, {'Content-Type' => 'text/html'}, ['test']]
    end

    def test_with_parameter(param)
      [200, {'Content-Type' => 'text/html'}, ['test param ' + param]]
    end
  end
end