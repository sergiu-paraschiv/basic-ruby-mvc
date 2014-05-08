module MyApp
  class Group2Controller

    def test(request)
      BRMVC::Response.new 'group2 test'
    end

    def other_test(request)
      BRMVC::Response.new 'group2 other_test'
    end

  end
end
