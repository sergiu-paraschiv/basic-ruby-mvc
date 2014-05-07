require 'rubygems'
require 'rack'

require_relative './bootstrap/start'

Rack::Handler::Mongrel.run(Rack::Builder.new {

    map '/resources/' do
      run Rack::File.new '/public'
    end

    map '/' do
      run BRMVC::App.new :MyApp
    end

}, Port: 9292)