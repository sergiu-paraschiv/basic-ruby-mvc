module MyApp
  class HomeController
    def index(request)
      'index'
    end

    def test(request)
      BRMVC::Response.new 'test'
    end

    def test_with_parameter(request, param)
      if param == '1'
        return BRMVC::Redirect.new(request.router.url :test_with_parameter, {:some_param => 2})
      end

      template = BRMVC::Template.new 'test_with_parameter'

      template.with({
        :param1 => param,
        :param2 => 'test'
      })

      template
    end
  end
end
