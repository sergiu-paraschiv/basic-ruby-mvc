module MyApp
  module SubGroup
    class GroupController

      def test(request)
        BRMVC::Response.new 'subgroup group test'
      end

      def other_test(request, some_text = 'optional', a_number = 1)
        BRMVC::Response.new 'subgroup group other_test ' + a_number.to_s + ', "' + some_text.to_s + '"'
      end

    end
  end
end
