module MyApp
  class Router < BRMVC::Router
    def routes

      get '/', MyApp::HomeController, :index
      # get '/test', MyApp::HomeController, :test

      get(
        '/test/:some_param',
        MyApp::HomeController,
        :test_with_parameter,
      )
      .where(:some_param, :number)
      .as(:test_with_parameter)

      group '/sub' do
        get '/test', MyApp::GroupController, :test
        get '/other_test', MyApp::GroupController, :other_test
      end

      group '/sub2', MyApp::Group2Controller do
        get '/test', :test
        get '/other_test', :other_test
      end

      group '/sub', :MyApp do
        group '/foo', :SubGroup do
          group '/bar', :GroupController do

            get '/test', :test

            get(
              '/other_test/:some_text?-:a_number?',
              :other_test
            )
            .where({
              :a_number? => :number,
              :some_text? => :alphanum
            })

          end
        end
      end

    end
  end
end
