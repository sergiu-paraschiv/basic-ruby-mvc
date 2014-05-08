module BRMVC
  class Template

    def initialize(path, parameters = {})
      @html = File.open(File.expand_path('../../../app/views/' + path + '.html', __FILE__)).read
      @parameters = parameters
    end

    def with_one(name, value)
      @parameters[name.to_s] = value
    end

    def []=(name, value)
      with_one(name, value)
    end

    def with(name, value = nil)
      if value.nil? and name.is_a? Hash
        name.each { |name, value| with_one name, value }
      else
        with_one name, value
      end

      self
    end

    def [](name)
      @parameters[key]
    end

    def to_s
      template = Liquid::Template.parse @html

      template.render @parameters
    end

  end
end

