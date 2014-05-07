module MyApp
  class Router < BRMVC::Router
    def routes

      get '/', 'MyApp::HomeController.index'
      get '/test', 'MyApp::HomeController.test'

      get(
        '/test/:some_param', 
        'MyApp::HomeController.test_with_parameter',
      ).where(:some_param, :number)

    end
  end
end