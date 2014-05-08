module MyApp
  class GroupController

    def test(request)
      BRMVC::Response.new 'group test'
    end

    def other_test(request)
      BRMVC::Response.new 'group other_test'
    end

  end
end
